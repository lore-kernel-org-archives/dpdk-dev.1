Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6D606A32D
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=dwVUWwFI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66C4D402F0;
	Sat,  7 Nov 2026 12:11:58 +0100 (CET)
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
 by mails.dpdk.org (Postfix) with ESMTPS id 06A74402EA
 for <dev@dpdk.org>; Sat,  7 Nov 2026 12:11:56 +0100 (CET)
Received: from [192.168.0.40] (unknown [37.228.226.247])
 by smtp06-ext.udag.de (Postfix) with ESMTPA id 98680E0635;
 Sat,  7 Nov 2026 12:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1794049916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qgfjyi7Ydkq4fzT5XN1f8RophRV6q8mAAwhGuXO9/iA=;
 b=dwVUWwFIOZpPBBQZhJo4pSb+CgTpk5V1iC2vjKhzhbZtchdiueTYnsBG+iR0emJXoNuboH
 woMyqHNET5grYttN7om4ys+6qYXqTdGBo8a7dOAEsBmEEf+m7OqCWDfsmQwhLQap9qpG4k
 amqP/OGhsNqehcTDm11XkPslBwNUtBMHpsugCCEP1IiUr7VC2LUx9zxEYHGCH1Ta73aNji
 9qr3qzmxAfehmMNbAxGZVPpuegn9MMHwTOHw3GQpSOpBFXac9dL6tYKR6+IE50OOxPTy1Z
 tD46tU4OdOJ3sjTP0EMgaeNkR/rQQ726UElcHi5OeIZscl7RfQatLUwl7x4fkQ==
Authentication-Results: smtp06-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <0374e022-3c41-4a6b-9464-7f879ef02ce1@dressler.pro>
Date: Sat, 7 Nov 2026 11:11:54 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af_packet: fix build with old kernel headers
From: Frank Dressler <frank@dressler.pro>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 david.marchand@redhat.com, ktraynor@redhat.com, Bing Zhao <bingz@nvidia.com>
References: <20261106142756.241131-1-bingz@nvidia.com>
 <dd205eb8-4741-452e-8490-16d157e1bb1e@dressler.pro>
Content-Language: en-US
In-Reply-To: <dd205eb8-4741-452e-8490-16d157e1bb1e@dressler.pro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_PRO_TLD,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 14:27, Bing Zhao wrote:

 > The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
 > but it was only added to the uapi headers in Linux 4.20. The build
 > fails on distributions shipping older kernel headers, like RHEL 8
 > (kernel-headers-4.18.0-193.el8, gcc 8.5.0):

On 11/6/26 16:06, Frank Dressler wrote:
 > If RHEL 8 uses Linux 4.18, [...]
 > If DPDK needs to stay compatible with RHEL 8, [...]

Short version: RHEL itself does't seem to ship any DPDK that is too
new for its kernel. The RHEL 8 compatibility requirement may instead
come from NVIDIA's DOCA, which ships DPDK 26.03 on RHEL 8. If so, the
question is whether upstream DPDK should support that combination, or
whether it is better handled on the DOCA side. Details below.

Bing Zhao, is that the use case behind the patch?

Details:
I read too much into Bing Zhao's statement that the new code does not
build with the RHEL 8 kernel. That statement is true.I incorrectly
assumed RHEL itself ships a DPDK version that is too new for its
kernel, which is not the case.

I went through the DPDK and kernel versions shipped in each RHEL
release [1]. All of them ship a DPDK version whose documented minimum
kernel is at or below the RHEL kernel:

  RHEL   | Provides   || DPDK       | Requires
--------+------------++------------+------------
RHEL 10 | Linux 6.12 || DPDK 25.11 | Linux 5.4
                      || DPDK 24.11 | Linux 4.19
--------+------------++------------+------------
RHEL  9 | Linux 5.14 || DPDK 25.11 | Linux 5.4
                      || DPDK 24.11 | Linux 4.19
                      || DPDK 23.11 | Linux 4.14
                      || DPDK 22.11 | Linux 4.14
                      || DPDK 21.11 | Linux 4.4
--------+------------++------------+------------
RHEL  8 | Linux 4.18 || DPDK 23.11 | Linux 4.14
                      || DPDK 21.11 | Linux 4.4
                      || DPDK 20.11 | Linux 3.16
                      || DPDK 19.11 | Linux 3.16
                      || DPDK 18.11 | Linux 3.2

I am not a RHEL user myself.Please correct me if I missed something.

Since Bing Zhao works for NVIDIA I thought of DOCA. DOCA-Host is
provided for RHEL/Rocky 8, 9 and 10 [2], and the DOCA 3.5.0 RHEL 8
repository contains dpdk-community-26.03.0.5 [3]. DPDK 26.03 documents
a minimum kernel of 5.4, while RHEL 8 ships 4.18. That's a mismatch.

So, unless I'm missing something, the RHEL 8 compatibility requirement
comes from DOCA rather than from RHEL.

[1]: https://rpms.remirepo.net/rpmphp/zoom.php?rpm=dpdk
[2]: 
https://developer.nvidia.com/doca-downloads?deployment_platform=Host-Server&deployment_package=DOCA-Host&target_os=Linux&Architecture=x86_64&Profile=doca-all&Distribution=RHEL-Rocky&version=8&installer_type=rpm_local
[3]: 
https://linux.mellanox.com/public/repo/doca/3.5.0/rhel8/x86_64/Packages/
