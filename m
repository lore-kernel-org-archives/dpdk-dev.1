Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF3C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 19:33:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E80754028F;
	Tue, 27 May 2025 21:32:59 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0C7C84028D
 for <dev@dpdk.org>; Tue, 27 May 2025 21:32:58 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id EC8B8206B768; Tue, 27 May 2025 12:32:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC8B8206B768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748374376;
 bh=OJ41AdKA84oxIJNExFRIJ9RYLY1aLUxum+VQT9hOXLQ=;
 h=Date:From:To:Cc:Subject:From;
 b=I4OZVCcQgPeGiQma/mzIDPzDUBrYn/AuXjcBmrCTLhF4ZG8krS8nMmzvmbOAsvTSN
 xJn46pllGEU4Y4Ll2IYnxJ1tbMj8F8joVh8uXiwpDjjMNQUsD2PUlXggxTi1Uxyqc9
 FjrC85sgXi0JcaTlqsxUoKcFZCZHSnhAKd7+Ukw8=
Date: Tue, 27 May 2025 12:32:56 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org
Subject: Looks like a bug: operands are different enum types
 'ibv_flow_attr_type' and 'ibv_flow_flags'
Message-ID: <20250527193256.GA6110@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
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

Hi Folks,


Compiling with MSCS resulted in the warning below:

../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287: operands are different enum types 'ibv_flow_attr_type' and 'ibv_flow_flags'; use an explicit cast to silence this warning

It looks like a legit bug. Here is the offending line:

	struct mlx5dv_flow_matcher_attr dv_attr = {
		.type = IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRESS,

As the warning states, the constants in the bitwise operation belong to different enums, and these enums have overlaping values, which makes the bitwise operation very suspicious.
On top of that, I see that struct mlx5dv_flow_matcher_attr has a field named "flags" which accepts values from ibv_flow_flags:

	struct mlx5dv_flow_matcher_attr {
		enum ibv_flow_attr_type type;
		uint32_t flags; /* From enum ibv_flow_flags. */

Could someone more familiar with the code take a look and make a fix if needed? My goal here is just to get the code to compile with MSVC without warnings. I can add a cast to remove the warning if this is indeed how the code should be, but I don't want to do this unless I get confirmation that this would be the right course of action.

Thanks,

Andre Muezerie
