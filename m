Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40FFCC6B2D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 20:50:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C67C40278;
	Wed, 14 Oct 2026 22:50:24 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id AEC504025A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 22:50:22 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 10B581D00115
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:50:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 14 Oct 2026 16:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792011021;
 x=1792097421; bh=XUSDN5wbAuVMk9taTJGjElYOq04rXz3trU/0WQPUicA=; b=
 a0WHct5YNswEqD+AMMd9CgvZ+6cp90gQLJH6RGJwBVHpL9CM+vpGN+PoCDoIgzEU
 /9ivAmLkN5rlYYk1Eot5YOIBTjji0PlOnFFW8/G2bg/eT56RmuANy0ldq53VsC0n
 G0LGmO9Qzc2Osttp1a3k5F0FQTs1+CaeBRcnE/Re9uwTUeEcipwhDa6Bxj4f/Bxv
 jweiFC98CGbasWMTvX4J3lQatoHAcUhdlCtibLjqw7Zg1pifTcz4Tt53YN0zzm56
 HC4PR4+A8GW0nBhC5CKMtqnMiCrMkBdjxyzVDZ9zw4TcKrKJXAhdV6DtjXZ6PLif
 IQFe1xyiuDd0k8o9l4Ohuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792011021; x=
 1792097421; bh=XUSDN5wbAuVMk9taTJGjElYOq04rXz3trU/0WQPUicA=; b=l
 9JqqFKWLy5EUUXpMc76/eluNMXd74FxH4FGgA6B3OXUxUvyEfsSUqpchEhspeeXa
 5gb0Qh7iwmvd6QB9LpEv0WlmGm+m6be2UMxmKYJ+1YxDdvpydN1ML8fgYbKqjngP
 SLU1YcsY9WGNIJdcySPWATLUqvT2uo4bKAEJDnhOPYVr1c0JdQRzaOmCDnsyXT64
 YZgA2AwEt1jgIWSt+6cpPG0ENVZp4n8FM2GRSSyyykugSOAecRq0yCs0GV1eV/Tn
 ALuFiWu2VceaOG5gLBXLz4WJ7dZB2mPU5DB+8F9Zp7dXA0cgpTi0TAQqvSyqdmSH
 pBDGJsuHNvr1RXrGF6NTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792011021; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:X8yGtADyi+5v7lHKoUoR8VdzkzsDd0u/TtE409UO9wInuY4
 1mk6Oafc8J3p14zQgNOry/NAfSDtWSXss2GzeQnRN+I+TZQA7c2nC5vcRRIRTmWf
 Y9oyDv76kedepgKPzUtO0HJb3+PvwvGE/iQOP7tpBlb5zz/EPXzx17hbHtQO4svs
 4/Sf9hqhItFh7e5snXl4bc4mF4GgZA8Jj/qc3dAMvDWHZGvblgdDLDkEN/UU9LM8
 R0joPhYTCdvyov1QdiIcyq1J1PQbubg65Vtf/aBo4lAzI+PJHx30pe12ZXWbuHl7
 LMXrLxUieELXUPnD+SQSuhz8lRV09cq/OW2wiaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:7zs3FpsQ1+nA3mpLNfGBE9uZn/OFA8gs1hgyoZQsloc=:OTGVJnMLmaBPf4MVEQGm72ylXaR41IIXRCifPn7sfWc=;
X-ME-Sender: <xms:DevPaj9AhK6wwoibIk5_huSYQuqQ2zBvlz40CKM4BaWxsquvYVJXFQ>
 <xme:DevPav11rQYJMAonn1EiuDTrcNSZA8P4r_xb2TLuRueM0KoPfgS6k6dZh1XsiB70e
 7ENhrIintscpnNn8tumfsX4FeiZR6fYh-RuhrJp6a9JkFavDH9m8A>
X-ME-Received: <xmr:DevPao-U60gpaphSz-oibQ2Rsjp36rlaRHqUtJMoLDtefPSwpewYkBC8Mu3FM2JikeZyn_YHiAyVmOFUQQPgWwU>
X-ME-Proxy-Cause: dmFkZTFOvLTU8wdUO/jD/SArgbtjYBl8qzHuKSWSf+pm7jpGOaMVDbaJTjydMqRsTqmo1F
 ba0QE5r6/Wy03ONHKBfEXoZXlZP+7Ah7BlBrgXoAE6sMJEFpbq3lmGI2OVomoQFTbJHYpP
 p6y+zUMvJVEqsj6m1Ska2Kejjs+nRM6njWWSdlytIxBcIpRLn+aDiO9ndSGpaB9lkuLJJI
 ERu4Cs4FV0/Km6fClRfsXni86sA9bibY1f8+SEKYWGCUD24kks5kxqnyeapq9g1ELetKuU
 39SAwW6SOEWZO3E0SZRsCOWLawmGl0/M6ZSUyWflKcqn7QMoeOWX3yZkwSbhks5ZesuRpS
 OmzeSdsZ8wGO2OXFSxGIFPkivSDBCcCmD4N3lxxtakVFfIH/iHKxVhkItZBspkh0AjFdU2
 s8VLOwwSglde1DxAc+9O1nATwH5+96oLZX+xpdYfobvNTF2GYNE/K/H766gl/lm9rcjxCJ
 as/jDl4nP2DYtbxoV4vdL/yrsPprYOfY4BGapJrlfTqtpZqJrtZxpOdvR/XKZ6GbZo9bxI
 tRSZTQMqs/cf1400WpglbzzVRFF34dNS0RcOZLvvtFBTfrty6iS+GIJH3RB/9hQcuXIQi9
 F9CXhMEv8Cg+eNNkCUImxYJ172On1F7Hh05XdmQ7z7OUn0cCdMjvNrPEaHmg
X-ME-Proxy: <xmx:DevPant7yQzM9OhRUEa3Yt0wAU9W7RXC6x-wsqAvxXU5XDQck6pmKA>
 <xmx:DevPajAjCGS9bfuqgyGr9AouVgYEkDB0Zoxmq9qfO9X776X97xThCw>
 <xmx:DevPanUpdNAnpBEjJ6N9iQNNByx0mZsU8CCjHgx1L7aUWrwSP7u0kg>
 <xmx:DevPapD60XkIFFNc2Q59GUOTYnbP2YbB8liI2xYJRaJRuVXsvasYWg>
 <xmx:DevPap7u176u2NjuFcSJh1itQn_uu2KJws5G7bTq-jSl1gNjpIFKyKfC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 16:50:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v7 00/25] Building a better rte_flow parser
Date: Wed, 14 Oct 2026 22:50:19 +0200
Message-ID: <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
In-Reply-To: <as5n5Gd_ibUFwu8T@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
 <as5n5Gd_ibUFwu8T@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

13/10/2026 19:18, Bruce Richardson:
> Patchset applied to dpdk-next-net-intel.
> 
> As well as the arm build issue, I also fixed a number of checkpatch issues,
> since there were a large number on this set. Most I kept unfixed, since I
> felt the exceptions were reasonable, but please check what was applied in
> case some issue was introduced with the checkpatch changes I made on apply.

Unfortunately it fails compiling on my FreeBSD,
because of an internal API included in a header included in testpmd.

You can make it fail reliably with Clang on Linux with this patch:
https://patches.dpdk.org/project/dpdk/patch/20261014201627.571496-1-thomas@monjalon.net/

And you can fix the problem with this patch:
https://patches.dpdk.org/project/dpdk/patch/20261014203435.583064-1-thomas@monjalon.net/

Please review them.

In the meantime I cannot pull this series in main,
except the first 2 patches for ethdev API.


