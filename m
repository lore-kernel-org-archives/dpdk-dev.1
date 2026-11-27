Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA14606A68B
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iyLP1AES
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEDD2402C4;
	Fri, 27 Nov 2026 18:38:32 +0100 (CET)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 12A2D402C1
 for <dev@dpdk.org>; Fri, 27 Nov 2026 18:38:31 +0100 (CET)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8b5a6f2f27fso3220316b3a.3
 for <dev@dpdk.org>; Fri, 27 Nov 2026 09:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795801109;
 x=1796405909; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3MK34r/u2071A40QTGtYXpnlrheo9dqkoyfal80WsMc=;
 b=iyLP1AES5FvITsZ9zZbZaQWGY/rrWbP/ya+ZEcqJ1RTC9NPpVgQ6TKs4NxB/+Rc5Gk
 BTJ39y9r/Gg7ZtUxIitTGw/pkE8KgGCLFcifFcI6UBLV3IA9fPtLTkASm2SROjosS0FD
 XCtfJrkDWa6tRlXMpvDtznoU7TyMKK6/BNScygnQxz71mCDRZMSubiGWLd0ongmyb9Wv
 Sxb3bls8wKNZNuv8g6BTNRi7bnTBRSKqvje8/1PW4zm3FIaicNl/H6j+OXbqC+9L03+S
 6Th96mTyO4aWRHE4TyjzlYmAqYuTOrnN3sZ6xIPqqZ2tmquHNHCuidZRe1H4GLoSmTQp
 7KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795801109; x=1796405909;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3MK34r/u2071A40QTGtYXpnlrheo9dqkoyfal80WsMc=;
 b=SOgqXY+NHHOq+dqJTdj+44DzmhgRMuViVBap7diGc43kxnuj6eGhELwXrGKOPjIbOo
 MkWTBBl9nt016RfaDzvA8Vcp2V+YAtrYwie3E9RThJmGjuW0+Vjb6WIW69j4cYKjU6cp
 chz6xTFVNEV1TsShGEKd4WnqiHEl2itNQv/zHtKq8Awmw1lf9U+DplZo2qX0/Uxdbg3p
 +1mgnuAKQYoPCtyaDKAzaqnUzUWp6TPVvbPQQA7+hktnY04W96cpHbf/SrQPFt6w19nz
 AnrZ6Rp1QuVpLi+tsQ5nF31j3LB/z25MNzV9uzZRAvn2Ma8KfzCQNu4a3720RjMskXNg
 Vbzg==
X-Gm-Message-State: APuU4Z8V5F3vcMfAdagyY53G4KL6UoYKDsR5tq9mEZCbPwpW9i2CznlF
 bRHQ5ruME6tr8uCmbvXmWjjUdCfwtYbJO0S1737Um1IoRBcp8vPK/N+003ClB14ZuOo=
X-Gm-Gg: AZFdTZckQqMJxyR+Y6KUFfQJZliflyzUkpsGFQdsGU3GveFVWjDZi6FOZGMpUJRMEhJ
 t9Sn3Wn7nmjdcM1RR2R6sEnHV2BDh0T8Zqs14N/wQdm/KYdFE5+i8Ey6Ik8A9bO/ftNfXPftobH
 OS4uDBg6H/4RRuRkKjCxcK6lMAq2XjeSjJC/tX9lxY03YJPfJPBZDlSUDj3MQSgo8c4ajL8I9Cp
 zqP1qBWpp7T5e+h60vRlGtY0wJwwgQ9GDZrBHHWqYceci3XINMVWBT0UKUczL59BANBNYywHmKW
 g/tQSJc48PLOx56BpcpddOF9CqsORqYuKVx/287fcv9Po9MdMGzAW4ivYFFzrbOrljmSwE/blLy
 yWn5CyXBCaVeTJNU2hJuN4AUDu6Dg8WiFaW2QlNVV6YSUG6bjRwCL258z/xgivcqnQPL22gBCKL
 oBDM4bY8yXGa6uPJin5LrVN+a0BSMYQWSNErRbKiQO0tXtsUf/F30AEwY1k0MXKqDX8BFypqB2N
 P775sIvV5JslII6eg+3M9UqGQrBqtvW8dwj4OZONY9E9WotzUtM8LNPK+hN/rftb4P1LZgn/Bxb
 bBVyZKgkYWAEnIBgcA9J3iuvrwHZ1dJ1xIvIef037bGQExnopCEMr4o0b9FSGTixvLxnOMgYZ1U
 +1vvTEArfd8K0PuOe
X-Received: by 2002:a05:6a00:1d8e:b0:8a0:7c97:52a1 with SMTP id
 d2e1a72fcca58-8c87d124d3cmr22743419b3a.48.1795801109521; 
 Fri, 27 Nov 2026 09:38:29 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87344184fsm13383399b3a.35.2026.11.27.09.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 09:38:29 -0800 (PST)
Date: Fri, 27 Nov 2026 09:38:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v9 00/30] net/hinic3: add PMD features and fixes
Message-ID: <20261127093827.4392f070@phoenix.local>
In-Reply-To: <20261125170425.5430-1-yejiacheng4@h-partners.com>
References: <20261125170425.5430-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 01:03:54 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and a handful of driver defects, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.
> 
> This version supersedes v8. v8 was applied to next-net; please drop it
> and use v9 instead.


Update the version in next-net.

Minor AI review info noted:

Info
====

[PATCH 15/30] v8 mapped the firmware NOT_SET value to AUTO on GET.
v9 drops that table entry, so hinic3_fec_get() now fails with -EINVAL
whenever the firmware reports NOT_SET:

	if (advertised_fec == 0) {
		PMD_DRV_LOG(ERR, "Firmware reported an unknown FEC mode (NOT_SET).");
		return -EINVAL;
	}

rte_eth_fec_get() can report AUTO, and NOT_SET is a state the
firmware produces, not a corrupt value. If NOT_SET means the mode has
not been forced, return RTE_ETH_FEC_MODE_CAPA_MASK(AUTO) as before
and drop the ERR log. If it can only happen in an error state, say
when in the commit message.
