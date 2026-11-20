Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA81606A685
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DpZR0q+o
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13F8340263;
	Fri, 20 Nov 2026 22:35:31 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mails.dpdk.org (Postfix) with ESMTPS id B4008400D7
 for <dev@dpdk.org>; Fri, 20 Nov 2026 22:35:29 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso728482a91.1
 for <dev@dpdk.org>; Fri, 20 Nov 2026 13:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795210528;
 x=1795815328; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GBwtqB/HBhPIZJf5VbVIdH5qFhgVLmkDLhuf/ohDA3E=;
 b=DpZR0q+oI71oD4kKmWdcbQY7314BDYyRDrR/Dm+kbvdLXpZqOkLc94f+8rr5fCe/hq
 W5Ct4bjLcFoz5a7g+vY1DegQ6iaxo3WkhdCmr3FSOLte/+0FHr5tQ3XtLhd8NNJEXZzW
 9FPsSS046RKLc6wePUQ5IEW/usSGCeyULXq8SggKznYJf0p8lKr09EJAZLKBsp42MZbS
 YutN1TDzukW8VlVL1ynY+JlIo0XcFxV2ZUM+zouPkO1ZDgiAoF2/ggotV1g2DzUbB7Z+
 hG9+acI2tOZGCmPVOsszlEpXJbhdBpK6eDCrpGPZmStGIC2hNCeR9nBxxzllj5tNeOby
 OD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795210528; x=1795815328;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GBwtqB/HBhPIZJf5VbVIdH5qFhgVLmkDLhuf/ohDA3E=;
 b=DOZj2z498NBGfBol0hEirpgs+ONyWLafhyS+u0lQ1G9Q1aBKOMMFs23A4ZqAxF0FD4
 C/WMb63HxZYmQDxAlN80iOr5ASkz++uCnuCRvjNRZWWklZo61LghNihhtcgbiBapjlwC
 gczYWB6oUmstnMTjv2Svb/R75yevGBLJlv0YiyA/+xTFY+Mrh+UNPPzibpO7JadZHmys
 tBQUf7KOnllELhJlZza4EAXunw9qhVkZIJ7/V+c0s6HsZ7gXRtykcjeARqS/y5FoR+HH
 RKbH1SOxlS45k6I5lQkeIMnr93t/UigND9yJrSqTxhVZUcauEGZT82XG7bhfHGw+Zhkp
 xfAg==
X-Gm-Message-State: APuU4Z9GYsRdvJAgSPcwfERE6IMANQk5pg/ZcBvPyOC+dbuBBBIEIdYL
 s2wDGVihoFViEJnyQAyjxxsADtxTnMJ84gnOHFqBxhPjI3xDBd6zCay6K5mqdVpw9oQ=
X-Gm-Gg: AZFdTZeIFT46vYd4d52pZOoEPPaTXhFDka7HT6HR4qRqbJ9zeAmN6S979nwDxjXMknr
 Ap0ryDm1N5TyijjMk2z2ptROO2th6EmESwO0k4owsjiiAfSbMScQiWLvW1cysAXLyR7kF3CoLR/
 Gdea6LDVacrHApt8JjL2ksS7z3KIv9P/fDW6Ri+craw6d7GA5JICsBeXRki+ZZ5voX0waQnlZ/d
 hupQEh2pyxCk76sTQFSbqYfQbBgmvUR/O0owo1CaWkU2B8BdP4iSb4ope3wosc3qGTqaDr9u5cu
 uf68pbSTFwr8S7w+SWuYcO+gE2n5w/QvPmF53LRJlko1gOE+/paMREHhTB4JDx34M3qVvvUkGZk
 KI8JUM3JmowVAhVvIALwGaeddEkpsOXdpGG6CaR5pf7AEocM+yRDHKPExti1LRs1I2dK8Kg8j6c
 An9kv9pzaJ4YLFGgH+uVhCylIo5jzeaAx+Z+pX1yaxcDrkhXabYwLzK9VQpSleVBHPQEmVnw894
 bQEAniNR3DmKPAyVLDjCgrCdtgr7+XDIvTfZLWwlPoV5p7RHBVr1eiUedrRh1y8BN6NpF25ZGeD
 FIPiKFzEl8W6Mj/84t02hyVunvPg6alBN+y8iIkrJkb0dyeW56JnlSpGwAOdfEb+dF+5NFI=
X-Received: by 2002:a17:90b:2ecb:b0:3b3:c45e:c715 with SMTP id
 98e67ed59e1d1-3b41c95e7bcmr3824288a91.50.1795210527796; 
 Fri, 20 Nov 2026 13:35:27 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41abb1b66sm5974961a91.1.2026.11.20.13.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:35:27 -0800 (PST)
Date: Fri, 20 Nov 2026 13:35:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v8 00/28] net/hinic3: add PMD features and fixes
Message-ID: <20261120133525.400a54bb@phoenix.local>
In-Reply-To: <20261120163454.1159-1-yejiacheng4@h-partners.com>
References: <20261117155711.1048-1-yejiacheng4@h-partners.com>
 <20261120163454.1159-1-yejiacheng4@h-partners.com>
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

On Sat, 21 Nov 2026 00:34:25 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and a handful of driver defects, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.


Applied to next-net for 27.03

The AI review noted:

Info
====

[PATCH 10/28] hinic3_check_rxq_intr_vec() also runs in the SP230
branch where the application did not ask for Rx interrupts. If there
are more queues than vectors, dev_start now fails for an application
that only polls. Consider falling back to the old behaviour in that
branch (leave dp_intr_en at 0 and log a warning) and keep the hard
failure only for intr_conf.rxq:

	if (hinic3_check_rxq_intr_vec(dev, dev->data->nb_rx_queues))
		return 0;

