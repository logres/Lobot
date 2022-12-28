from nonebot import get_driver

from .config import Config

from nonebot import on_command
from nonebot.matcher import Matcher


global_config = get_driver().config
config = Config.parse_obj(global_config)

# Export something for other plugin
# export = nonebot.export()
# export.foo = "bar"

# @export.xxx
# def some_function():
#     pass

matcher = on_command("SayHello", priority=1)


@matcher.handle()
async def _(matcher: Matcher):
    await matcher.send("Hello")
