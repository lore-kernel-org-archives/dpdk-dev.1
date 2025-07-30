Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E62C87FCC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 11:33:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CC9940E41;
	Wed, 30 Jul 2025 13:33:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C1FAD40E32
 for <dev@dpdk.org>; Wed, 30 Jul 2025 13:33:28 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26C3D1E5E;
 Wed, 30 Jul 2025 04:33:20 -0700 (PDT)
Received: from [192.168.50.107] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 4F1A23F673; Wed, 30 Jul 2025 04:33:27 -0700 (PDT)
Message-ID: <b8c608c8-bcae-4bc3-a899-6fb232af4c74@arm.com>
Date: Wed, 30 Jul 2025 12:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dts: add qinq strip and VLAN extend to testpmd
 shell
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250605184143.498892-2-dmarx@iol.unh.edu>
 <20250717205718.108826-1-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250717205718.108826-1-dmarx@iol.unh.edu>
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

Looks good to me, just some minor comments.

On 17/07/2025 21:57, Dean Marx wrote:
> +    def set_vlan_extend(self, port: int, enable: bool, verify: bool = True) -> None:
> <snip>
> +            if enable ^ (vlan_settings is not None and VLANOffloadFlag.EXTEND in vlan_settings):
> +                self._logger.debug(
> +                    f"""Failed to {"enable" if enable else "disable"}
> +                                   extend on port {port}: \n{extend_cmd_output}"""
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"""Failed to {"enable" if enable else "disable"} extend on port {port}"""
> +                )
Please don't use triple quotes if you need to break a line, or if you 
don't need a reason like for InteractiveCommandExecutionError.

Breaking a line with triple quotes will result in all the whitespace 
being considered as part of the string. You can just as easily split by 
writing multiple quoted text next to each other:

   self._logger.debug(
       f"Failed to {...} extend "
       f"on port {port}..."
   )

> +    def set_qinq_strip(self, port: int, enable: bool, verify: bool = True) -> None:
> <snip>
> +            if enable ^ (vlan_settings is not None and VLANOffloadFlag.QINQ_STRIP in vlan_settings):
> +                self._logger.debug(
> +                    f"""Failed to {"enable" if enable else "disable"}
> +                                   QinQ strip on port {port}: \n{qinq_cmd_output}"""
> +                )
> +                raise InteractiveCommandExecutionError(
> +                    f"""Failed to {"enable" if enable else "disable"} QinQ strip on port {port}"""
> +                )
Same problem as above.
