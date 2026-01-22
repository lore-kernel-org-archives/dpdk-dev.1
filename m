Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711E7C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 11:57:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E3424027A;
	Thu, 22 Jan 2026 12:57:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5C4064021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 12:57:38 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BC4E1476;
 Thu, 22 Jan 2026 03:57:30 -0800 (PST)
Received: from [10.57.94.77] (unknown [10.57.94.77])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 333F33F740;
 Thu, 22 Jan 2026 03:57:36 -0800 (PST)
Message-ID: <00c96241-3728-414c-bd1b-a1a0f28e2423@arm.com>
Date: Thu, 22 Jan 2026 11:57:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dts: add test case docstring checks to format script
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250826200720.104443-1-dmarx@iol.unh.edu>
 <20251106181355.209706-1-dmarx@iol.unh.edu>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20251106181355.209706-1-dmarx@iol.unh.edu>
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

Hi Dean,

Sorry for the long wait, this should be the last version as it looks all 
good to me. Only thing is that the call to the script needs fixing.

On 06/11/2025 18:13, Dean Marx wrote:
> diff --git a/devtools/dts-check-format.sh b/devtools/dts-check-format.sh
> index 907eed1293..f2cd5a56a1 100755
> --- a/devtools/dts-check-format.sh
> +++ b/devtools/dts-check-format.sh
> @@ -13,6 +13,7 @@ usage() {
>   format=true
>   lint=true
>   typecheck=true
> +docstringcheck=true
>   
>   # Comments after args serve as documentation; must be present
>   while getopts "hflt" arg; do
> @@ -97,6 +98,13 @@ if $lint; then
>   		echo "ruff not found, unable to run linter"
>   		errors=$((errors + 1))
>   	fi
> +	if $docstringcheck; then
> +		docstring_script_path=$(dirname "$0")
> +		docstring_script_path=$(cd "$docstring_script_path" && pwd)
> +		docstring_script="$docstring_script_path/dts-check-docstrings.py"
> +		$docstring_script

This way of figuring out the path doesn't work for me and our internal 
CI, so it's causing the script to fail.

This script already defines $directory and cds into it. Therefore you 
can always assume that the current working directory at this point is 
the dts folder. You can therefore remove the 4 lines above and just do:

                 ../devtools/dts-check-docstrings.py

> +		errors=$((errors + $?))
> +	fi
>   fi
>   
>   if $typecheck; then
I've made this change myself to test if the script works correctly, and 
it does seem so. Only problem is that it now causes the CI to fail 
because of a test suite (dynamic_queue_conf) not respecting the checks. 
It'd be great if you'd also send a patch along this one fixing that test 
suite.

Best,
Luca
