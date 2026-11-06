Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22889606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=TmKzngDH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64775402F0;
	Fri,  6 Nov 2026 17:07:01 +0100 (CET)
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
 by mails.dpdk.org (Postfix) with ESMTPS id EFD15402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 17:06:59 +0100 (CET)
Received: from [192.168.0.40] (unknown [37.228.226.247])
 by smtp06-ext.udag.de (Postfix) with ESMTPA id 2F133E0BD8;
 Fri,  6 Nov 2026 17:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1793981219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7XrpopJgxR8rG2O2w7CjufvJ7aS4hTLFXV1wG5N0bo=;
 b=TmKzngDHqKJ+dZo0DwMFRtrG8AKmkl3I1waOSBYr4k7L6YOHQ3mWZsh2QO+GwB5VBhaGvW
 m9xUVBiX014zVFya7rQO9/GvsVivFSyZ+nXQnoswP2/JGtbUN2dvgL7ptsob6CmJlc+8/h
 LhEMVWoiWcgozLx6HZ6u0aUGavTx2z29eFsnyimbvLmTq5jw7QNrwCFD+QausQMBKzQs4r
 YJd83k4XO48bUC7ftcfzCDp/8YF3e3T3NsDJvNOR45VFfW1hkTxDqT6wTGmEHZ6R/lNaxb
 xXTrDBknaOBa2Tq+5MO32nQUouvDXDULffcDJQ+8/QToG/X1tdqpiIR/aqp3gA==
Authentication-Results: smtp06-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <dd205eb8-4741-452e-8490-16d157e1bb1e@dressler.pro>
Date: Fri, 6 Nov 2026 16:06:57 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af_packet: fix build with old kernel headers
To: Bing Zhao <bingz@nvidia.com>, dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net, david.marchand@redhat.com
References: <20261106142756.241131-1-bingz@nvidia.com>
Content-Language: en-US
From: Frank Dressler <frank@dressler.pro>
In-Reply-To: <20261106142756.241131-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_PRO_TLD,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 14:27, Bing Zhao wrote:

 > The PACKET_IGNORE_OUTGOING socket option is used unconditionally,
 > but it was only added to the uapi headers in Linux 4.20. The build
 > fails on distributions shipping older kernel headers, like RHEL 8
 > (kernel-headers-4.18.0-193.el8, gcc 8.5.0):
 >
...
 >
 > DPDK documents Linux 5.4 as the minimum kernel, but the PMD already
 > tolerates older kernels for multi-queue ports. Do the same here
 > instead of failing the probe, for example on the 4.18 kernel of
 > RHEL 8.
 >
 > Fixes: 3db7aa7868b2 ("net/af_packet: use kernel to filter 
single-queue Rx")
 >
 > Signed-off-by: Bing Zhao <bingz@nvidia.com>
 > ---
 >  doc/guides/nics/af_packet.rst             |  1 +
 >  drivers/net/af_packet/rte_eth_af_packet.c | 16 ++++++++++++++--
 >  2 files changed, 15 insertions(+), 2 deletions(-)
 >
 > diff --git a/doc/guides/nics/af_packet.rst 
b/doc/guides/nics/af_packet.rst
 > index 6282f1e18b..09e79ff392 100644

Thank you for the patch.

I do not think it is a literal fix since the feature to ignore outgoing 
packets in the AF_PACKET PMD was added new in DPDK 26.11 which requires 
Kernel >= 5.4 which you mentioned.

It is, of course, a valuable feature to older versions of DPDK and/or 
Linux. I added that feature in a patch series. The first patch of that 
series adds the feature in a way that does not require 
`setsockopt(...PACKET_IGNORE_OUTGOING...)`, doing all the filtering in 
the PMD. It is in commit b44eeed1d7. It could be cherry picked to the 
stable versions, providing that feature in DPDK versions that still 
support the older kernel.

If RHEL 8 uses Linux 4.18, and there is a requirement somewhere that the 
current DPDK must be compatible with it, should DPDK's Linux kernel 
required be lowered to 4.18 maybe?

According to the docs, the following stable versions [1] are still 
support which I have annotated with the documented required Linux kernel 
versions [2]:

* 23.11, EOL December 2026, Linux >= 4.14
* 24.11, EOL December 2027, Linux >= 4.19
* 25.11, EOL December 2028, Linux >= 5.4

[1]: Stable Versions: https://core.dpdk.org/roadmap/
[2]: Requirements: 
https://doc.dpdk.org/guides-23.11/linux_gsg/sys_reqs.html 
https://doc.dpdk.org/guides-24.11/linux_gsg/sys_reqs.html 
https://doc.dpdk.org/guides-25.11/linux_gsg/sys_reqs.html

To me this looks like RHEL 8 is simply not compatible with DPDK 25.11 or 
newer if it is still using Linux 4.18. Lowering the required version to 
4.18 would be odd considering 24.11 requires 4.19 and 25.11 5.4.

If DPDK needs to stay compatible with RHEL 8, would this compatibility 
be required in all parts of DPDK or only some? If only parts, which 
parts or areas? Maybe these parts and areas then need to be listed 
somewhere so that new patches can be developed accordingly.



