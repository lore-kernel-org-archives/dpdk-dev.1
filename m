Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A51606A688
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=KWVtmZlP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WBiwVQaV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE3614027A;
	Wed, 25 Nov 2026 16:23:24 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTPS id 8440640151
 for <dev@dpdk.org>; Wed, 25 Nov 2026 16:23:23 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ADAAE14003B2
 for <dev@dpdk.org>; Wed, 25 Nov 2026 10:23:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 25 Nov 2026 10:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795620202;
 x=1795706602; bh=QqiMBkYownJ199Cc0JzODYupyMGaqNYCj8vg391cnG8=; b=
 KWVtmZlPaBKA1KmNkwS+wCFGBD/rB0OLKy7/fH4U6aaDYgBqt5hRIsBv8v1J4Jhl
 ulDeQxqxbT+4+6hNU3TlQI3rHs5TFaFjnIN9EBfXPYy6FENlMQZqAvrELPyeOnMi
 suRmzRUjLxGdw0Gh6Q7jU3gxu5quC/K3NrWLavUGDYrAHi7ORKKTc+Ro5n90Eq4m
 AI1/ujyAHkeVBj70Fmd0uxFx/wq0WZsN8aIMIzfrfqWWb9H7wC2J9PGAHDAe9thf
 K5CXLynW4JiR2tS6pk435uT4TmtH5HSm86DswzfhpuF9tf3M2gI4NwdHsa/MBefQ
 rMUEOrj9meeCWnEzoStNMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795620202; x=
 1795706602; bh=QqiMBkYownJ199Cc0JzODYupyMGaqNYCj8vg391cnG8=; b=W
 BiwVQaV021IU5m738jjv9rQb3BcJks2sL8W6xhBEHKG6A8o21crbMbLEDyMzGWDl
 x5QTTnQkXycbpYAM431TxITu4U8ZZA6dKq+oz0V+dv8hcvrzTY6XkT6y2LNnpwrA
 0NgrBdAg/ZuP0UbFIER7vMByLKaDbV1TozBguXiAnZMThsHY+n4cwM16lhns0YaI
 9GlPtDneFu/EtAORGmLP/vOpzGN7NWBTGWSPxtzQg+Gg5+Lb8kBkblqvdd2ZP2gh
 bmPD6U2dJfVitTBW9pRAwU5NsxX/b5fB8pgF+K586+3Zk2AzftcMo6dPewFsBDGO
 oGeBHmowCCd3XbVPVMpyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795620202; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:IMu8FJ6Sop8Hs/e5XjKW6kqQndA6kaU0q/O3G9/ntTdnRFG
 wZjvKKxveNBOzeTDOI05OaYdFDFtYz6JEETuYak39dxy2b7uQEx79/1ivn0Z5h47
 dqZIHtArXlRq7f0S9tQgVgIkPv4xwsQHk3vKKJGVfEvxPwhQO/BkIpIn+2Z9Pyq1
 YTIofUfOjn7bv3GtpXhyOkOZ4UO0yhoZNC5jSPKIIHpktXH0c8/R6uM0IGs3I3s+
 KkVyH44Z/qaLNrA5NNBwJl1fGZH8yhGJbKxmoIs1ivfPSx6cYOn0kMsbHHvL/xza
 QOIJ0P6knWI5XmGKFoLD4eUdMNwNZiGtHIxD8yQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:pfFjtbExfsYoEpvTT0X9L7Mc/qrb7ppX8r496VurALM=:hrlEOMN3cvh480b+HplSR/lEQxDjRVZktB6XQPBKqO0=;
X-ME-Sender: <xms:af0Ga9XbfcZkdySpofxW5b38LG20Oi50dVHJg0dQ9pWsddKtmcICfw>
 <xme:af0Gax7jC5Ph9NdC8bR9Kaf1BTI-xCClGA7Rdok3rH_U45I0zDc06QLmRNbjYi_zZ
 8VlP22vTIuOoSz64FByrXbbxIU-t_-oc_3fJ0oVVO137Ckaz_b4HZs>
X-ME-Received: <xmr:af0Ga4haWYkuIadlJZkzIarwCmCvTxd539L45-BqdrHG3aQ0M67_TpbzVinb9ORZW2Uw_0fQ98TSEDbB-tQTPqc>
X-ME-Proxy-Cause: dmFkZTFl4YcUVIJxaCjw7vxqe3MnmGkZnlOvRkBTuBPTjzXpJJMsmGFoQaROGVvTrcjtTb
 c52Ei/CV7U+jhRZbDDdNVKhqn9HZf+WzMrdV/eN2lr84J4btAtKumjrXLFJXeFfn/kCpzB
 iI44gbjUBW9nF1s2FGsh9OoVxs56ZZ/R9u2dT+Y7rkdG3HzeHcfp2FKEuVVk5dATJgamsS
 jZCkNd1IBg5p0DGASgSjyRducoaiJrJTF/JH5IfF3reJQ7b+e9huOMMPk3fGQmRGclCFpd
 nTquGqBnVY4FP0Wv5heLLhcs350G8JysFEltMtEiWK6lGEifDyFgk3VttMa01jYbtRZ0Uz
 dsjw5L4YfPwQwEZKPch8Md3wkS4UciyxHb1o26cVGa7IA4P0MF9BCjTLZBmdfW4D6q4nRL
 LC54+kUXW/+gbMhuurO8ku19GOTFvbY19LS9qqmEdY17L3YbwUKrdZKT2QZDTvPmXSsIjx
 U5CNLg+e7JZS+orELPs538LG8rgruVxgDGOBAaup7/5xG2OX//Op75UyKb6pnnywJ6oiy3
 RBsEm5GLilKJU5ToKoMrJbwSfO0ip0/lPcF5tQiLXzhERzT/DDv1rFZSfw0izguEAD0F2H
 bPwGxSYAO13ndCGaeQHIb8vopprfnlQVidbA3lTHitfqK+T11kv9gaM/LscA
X-ME-Proxy: <xmx:af0Ga4ezk9n5GC3H-F8aLsqPCm0EWuwQODOA1T8twBLGSN-OmVD61w>
 <xmx:av0Ga9fCIB6BtRMZX4_Uo2faIqIi_5z8UC-F5JBxGChfAxyZmo6NHQ>
 <xmx:av0Gay-j_jvpk9oGs2vzecYLyVeGr1_ResMi4-XOUQzNkD1KAU5bZg>
 <xmx:av0Ga5kwve3cJIfbPrfKpGOT5BqxNubHF7gNdCLyTclC5PzYHgU_Kw>
 <xmx:av0Ga8tEL4AFbXyJwRsaVUXg70yIhls0oSMq0kcY-mZedfg1vTjcu0eQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 10:23:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v4 6/7] doc: add missing drivers to doxy-api.conf.in
Date: Wed, 25 Nov 2026 16:23:19 +0100
Message-ID: <6TrJKj8QS2WF-RPENBY-1Q@monjalon.net>
In-Reply-To: <20260721145841.7424-7-marat.khalili@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
 <20260721145841.7424-7-marat.khalili@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

21/07/2026 16:58, Marat Khalili:
> +                          @TOPDIR@/drivers/baseband/acc \
> +                          @TOPDIR@/drivers/baseband/fpga_5gnr_fec \
> +                          @TOPDIR@/drivers/bus/pci \
>                            @TOPDIR@/drivers/bus/vdev \
> +                          @TOPDIR@/drivers/bus/vmbus \

There is a deprecation notice for rte_bus_vmbus.h


>                            @TOPDIR@/drivers/common/dpaax \
>                            @TOPDIR@/drivers/crypto/cnxk \
>                            @TOPDIR@/drivers/crypto/scheduler \
> -                          @TOPDIR@/drivers/event/dlb2 \
>                            @TOPDIR@/drivers/event/cnxk \
> +                          @TOPDIR@/drivers/event/dlb2 \
>                            @TOPDIR@/drivers/mempool/cnxk \
>                            @TOPDIR@/drivers/mempool/dpaa2 \
>                            @TOPDIR@/drivers/net/ark \
> +                          @TOPDIR@/drivers/net/avp \

rte_ files in avp driver are not supposed to be exported I think.


>                            @TOPDIR@/drivers/net/intel/iavf \
>                            @TOPDIR@/drivers/net/intel/ixgbe \
>                            @TOPDIR@/drivers/net/mlx5 \
> +                          @TOPDIR@/drivers/net/ntnic \
> +                          @TOPDIR@/drivers/net/ring \
>                            @TOPDIR@/drivers/net/softnic \
> +                          @TOPDIR@/drivers/net/txgbe \

There is no function in rte_pmd_txgbe.h, it looks like a mistake.

> +                          @TOPDIR@/drivers/net/vhost \
> +                          @TOPDIR@/drivers/power/kvm_vm \
> +                          @TOPDIR@/drivers/raw/cnxk_gpio \
>                            @TOPDIR@/drivers/raw/dpaa2_cmdif \
>                            @TOPDIR@/drivers/raw/ifpga \
> +                          @TOPDIR@/drivers/raw/ntb \

The rest are good additions.


