Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F88CC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 12:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 345FA40BA4;
	Tue,  5 Aug 2025 14:27:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5552140A4B
 for <dev@dpdk.org>; Tue,  5 Aug 2025 14:27:38 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50714150C;
 Tue,  5 Aug 2025 05:27:29 -0700 (PDT)
Received: from [10.1.30.58] (JR4XG4HTQC-2.cambridge.arm.com [10.1.30.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AB8B3F738;
 Tue,  5 Aug 2025 05:27:36 -0700 (PDT)
Message-ID: <37a33698-7c3d-4c9a-89bd-e1842c108abb@arm.com>
Date: Tue, 5 Aug 2025 13:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: update hinted return types of various methods
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250804200019.219458-1-abailey@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250804200019.219458-1-abailey@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hi Andrew,

congratulations on your first patch to the mailing list! For v2 please 
make a change to the .mailmap file, adding your Git name and email 
address appropriately respecting the alphabetical order.

Like I already pointed out a couple of times below, it may be worth 
considering fixing the argument types as well in this patch.

On 04/08/2025 21:00, Andrew Bailey wrote:
> Added return type hints for every method, function, and constructor in
> DTS where they were missing.

just a nit but good to know, the commit description justifies what the 
commit is changing or adding, and it explains why. Not what you did 
prior to commiting. In other words, it should maintain an imperative 
verbal form. You are doing this because mypy disables static checking on 
improperly typed signatures. For example:

     Mypy does not check functions and methods that are not entirely type
     hinted. This prevents full checks.

     Add missing return type hints for every method and function.

The commit subject looks good otherwise, it's in the right form. 
Sometimes to avoid making a subject that is too long it's preferable to 
keep it as concise as possible.

> 
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
> <snip>
> diff --git a/dts/framework/context.py b/dts/framework/context.py
> index 4360bc8699..969c541975 100644
> --- a/dts/framework/context.py
> +++ b/dts/framework/context.py
> @@ -4,6 +4,7 @@
>   """Runtime contexts."""
>   
>   import functools
> +from _collections_abc import Callable

Was this meant to be imported `from collections.abc`?

>   from dataclasses import MISSING, dataclass, field, fields
>   from typing import TYPE_CHECKING, ParamSpec
>   
> @@ -97,12 +98,12 @@ def init_ctx(ctx: Context) -> None:
>   
>   def filter_cores(
>       specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool | None = None
> -):
> +) -> Callable:

Callable without narrowing the types is too generic. Given filter_cores 
is meant to be applied only on objects implementing TestProtocol, I'd 
base Callable off of that.

>       """Decorates functions that require a temporary update to the lcore specifier."""
>   
> -    def decorator(func):
> +    def decorator(func) -> Callable:

I know this commit only covers return types, but func needs to be type 
hinted as well in order for this to work.

>           @functools.wraps(func)
> -        def wrapper(*args: P.args, **kwargs: P.kwargs):
> +        def wrapper(*args: P.args, **kwargs: P.kwargs) -> Callable:

Callable here is just `type[TestProtocol]`. It's type[..] because we are 
passing a reference to the class and/or methods, not an instance.

>               local_ctx = get_ctx().local
>   
>               old_specifier = local_ctx.lcore_filter_specifier
> diff --git a/dts/framework/logger.py b/dts/framework/logger.py
> index f43b442bc9..b073d8b8e0 100644
> --- a/dts/framework/logger.py
> +++ b/dts/framework/logger.py
> @@ -36,7 +36,7 @@ class DTSLogger(logging.Logger):
>       _stage: ClassVar[str] = "pre_run"
>       _extra_file_handlers: list[FileHandler] = []
>   
> -    def __init__(self, *args, **kwargs):
> +    def __init__(self, *args, **kwargs) -> None:

Missing argument types. It may be worth doing this together in this 
commit in fairness.

>           """Extend the constructor with extra file handlers."""
>           self._extra_file_handlers = []
>           super().__init__(*args, **kwargs)
> diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init__.py
> index 1ae227d7b4..e1c47c7fc4 100644
> --- a/dts/framework/params/__init__.py
> +++ b/dts/framework/params/__init__.py
> @@ -75,7 +75,7 @@ class BitMask(enum.Flag):
>           will allow ``BitMask`` to render as a hexadecimal value.
>       """
>   
> -    def _class_decorator(original_class):
> +    def _class_decorator(original_class) -> Any:
Missing argument type, this should match the return type. `Any` is too 
generic here. You should be able to use T here, as suggested by the 
outer function's return type.>           original_class.__str__ = 
_reduce_functions(funcs)
>           return original_class
>   
<snip>
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index ad8cb273dc..58655c96b1 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
<snip>
> @@ -90,7 +99,7 @@ class VLANOffloadFlag(Flag):
>       QINQ_STRIP = auto()
>   
>       @classmethod
> -    def from_str_dict(cls, d):
> +    def from_str_dict(cls, d) -> Self:d is not type hinted>           """Makes an instance from a dict 
containing the flag member names with an "on" value.
>   
>           Args:
<snip>
> @@ -1449,7 +1458,7 @@ def requires_stopped_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
>       """
>   
>       @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
> +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
Any is too generic, you may want to look at `only_active` in 
interactive_shell.py to see how it's done there. It should be the same.> 
           if self.ports_started:
>               self._logger.debug("Ports need to be stopped to continue.")
>               self.stop_all_ports()
> @@ -1470,7 +1479,7 @@ def requires_started_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
>       """
>   
>       @functools.wraps(func)
> -    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
> +    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
As above>           if not self.ports_started:
>               self._logger.debug("Ports need to be started to continue.")
>               self.start_all_ports()
> @@ -1492,7 +1501,7 @@ def add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdShellMethod], TestPmdShe
>   
>       def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
>           @functools.wraps(func)
> -        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
> +        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
As above>               original_mtu = self.ports[0].mtu
>               self.set_port_mtu_all(mtu=mtu, verify=False)
>               retval = func(self, *args, **kwargs)
<snip>
> diff --git a/dts/framework/settings.py b/dts/framework/settings.py
> index 3f21615223..b7dbf0bba6 100644
> --- a/dts/framework/settings.py
> +++ b/dts/framework/settings.py
> @@ -237,7 +237,7 @@ def find_action(
>   
>           return action
>   
> -    def error(self, message):
> +    def error(self, message) -> None:
message missing a type hint>           """Augments 
:meth:`~argparse.ArgumentParser.error` with environment variable 
awareness."""
>           for action in self._actions:
>               if _is_from_env(action):
> @@ -257,7 +257,7 @@ def error(self, message):
>   class _EnvVarHelpFormatter(ArgumentDefaultsHelpFormatter):
>       """Custom formatter to add environment variables to the help page."""
>   
> -    def _get_help_string(self, action):
> +    def _get_help_string(self, action) -> str | None:
action missing a type hint>           """Overrides 
:meth:`ArgumentDefaultsHelpFormatter._get_help_string`."""
>           help = super()._get_help_string(action)
>   
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index 8ce6cc8fbf..f6ae91c142 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -77,13 +77,13 @@ class ResultLeaf(BaseModel):
>       result: Result
>       reason: DTSError | None = None
>   
> -    def __lt__(self, other):
> +    def __lt__(self, other) -> bool:
other missing type hint>           """Compare another instance of the 
same class by :attr:`~ResultLeaf.result`."""
>           if isinstance(other, ResultLeaf):
>               return self.result < other.result
>           return True
>   
> -    def __eq__(self, other):
> +    def __eq__(self, other) -> bool:
other missing type hint>           """Compare equality with compatible 
classes by :attr:`~ResultLeaf.result`."""
>           match other:
>               case ResultLeaf(result=result):
Thank you for your contribution!

Best regards,
Luca
