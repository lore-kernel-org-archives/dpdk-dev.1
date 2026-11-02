Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0126070C80
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=guCBI9Z2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PPvOV6aR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94A8940EAB;
	Mon,  2 Nov 2026 15:48:12 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTPS id D42E940E4C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:48:10 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id B82C21D00187
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:48:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 09:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793630889;
 x=1793717289; bh=mWh5Fm3UE/999lZ5BlJsZI6wc72jfXhFS4iAXaVMmFw=; b=
 guCBI9Z20q626eV8kMAhxnLksrtZdBIpv9jt/ZOfRGni0A3kB1enwjFwJv3Pr6Lo
 StGsXKXlsu8ccoAsfvMAafIaGmw3xVTomiyT+ELgD91VnENIHA9+QoS5JTTQnb3V
 B+F5VCvsw/qQlnWG4vx5ESsc84pgxYH/uQIzxHp/zjSyLh5TU3jtEn4VI02VHdyC
 x6FZSLtE0z/EAJQRBke1S/JntsMOYt024OxKJipu7fj8ICtWsHI+oucOMcZhXLpA
 MjZUEc9g4AfYN4Jg5i35mu7ESLl6TjZSnaZ703XLAgwOQLujdRSxrn5gXHlkolKp
 QpjLXH0/D2ivSsvVYar7vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793630889; x=
 1793717289; bh=mWh5Fm3UE/999lZ5BlJsZI6wc72jfXhFS4iAXaVMmFw=; b=P
 PvOV6aRMiQmumjAS1/VuOBamKlFz6/KHFg1EEOV90hyJIh9vNagERPpUAAO5HjQm
 L8RFEyp1Nmp3lr2gdyPTBol7/0bYmrTsXiz2HaRONUiMAmVH/SGqq23/u//5kmGg
 kMXG7TQigANqTgSwupgEgOBcUbfqTe5DDOqotbhmopgwaZqrOMunudg4xzDkrIhF
 TLwVpKPSqqRAg7CratgzLdy9vurg4Sxkpwo8jw8kskfttbIolXvXLDq90scd7582
 YPuaLYjDtQS90hpb6M6G1sf5aqaOzPBzZTkB26hn1QTMmtl2RDVlTVfyJzKO7bMs
 tpNX33WdYfYZxTzonGhoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793630889; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:O8cMeCicqMci5RrVQ4XBXgIPbzDsVymdB+LwWfZBnqOjNn/
 gYJppCaOcN1Zzst6+5Km0auCkYngZEjCJIx6/oA7NuAfmSV+foIBlTBnb74z+BSn
 LXAFsT8GaomHT3Hy19/1WC3V07c58ZZChgOW2RPL9SxBD4sUOpk8RxAwWkNzoapa
 p7XizVVmEF3nnCvgnyI1p3HmKCxzUFJq0WZwaAe95CrBsk5ph2CDWu7u3mB52l7x
 Y5o/jCtCyHnlRS8dni9C7KJ0GMtJaBfzckgyCnccHVMpnW6zRjQAcaGdcEQiLTht
 Bca9h4rqC+RMSKRQCeFY5tqPjqvc1DaKHgcbyVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:cAhdEwp3pVMWjdBvUh5T9kTRrwwLkKzqyQ5dCYG1BTs=:mWh5Fm3UE/999lZ5BlJsZI6wc72jfXhFS4iAXaVMmFw=;
X-ME-Sender: <xms:qaLoasFsimvZe0_YyGxgyrvjOcqP0AlAlakA4tctCfBS6XxRo-Yc2g>
 <xme:qaLoauQNjsscUX5VCs0szQIM-5P-ZKoIngWXV9IgpYnkmFNBvZdtLT-Q54MP0xEDd
 R72W9od4QHtL9E571Unl_Y82tzl-79VjsIM6brYQpJXy4Q28mq957A>
X-ME-Received: <xmr:qaLoahsKYCiw--6bincd_OtbdwB3PuyLUI6xbISMd3WwSNUVwp2ltaj6d3201ujoHHPu8GlXyUr27jVA0w8_Wpg>
X-ME-Proxy-Cause: dmFkZTGD7bKw8VZpCqraAsvK9l1O+oNItmGDle+qi2UVvqYTIr0ph9vaVF3R2FK5Jkw+Lu
 A5GUuBtJXp706orW2licalRJujC1wHnBX34j4n3lZk6ZBx+F/W5yqjR1EF0BeHEic32+DI
 bsF/1ptXgopYCN/nLBWnoP9a48Bl8ggjFBzb0qw4VD4MM5q31IbkFtBtna8fQnRovXf2OS
 MD0kexE1F1pTVe4cvhlgblyW9T5ZKMGrP3WRMmgQh+XpRaRLm9GAjcNPYFdz/2+qUfgzzz
 TObOOOtMOtIwC3q4qMvih36mk4TCwI6l2/WtbMEDl7aITbItUsYtXXYwGalt5rykg4psIK
 gWyT8CUp2MqHOhMFaSvLezjuvLFXpw2f4oofOXJSBB86XuggErbcJUC9Vfj5gdMkNYPkGP
 WZuISlYDNsco9Iw841aMRVlvIGz2FjIaelS2rZIBFALXM3i1AO23pjz9N2WDwquzjqQHid
 zOhInZbv2mobr9zkmLO1hokxheCOTUUHgwRHWQTM69AhchJQB3vttHxy1m30OGuN2wUIBz
 kHC3uUFiNxnvHva4unScnTHj9xxI3MxJkjgkNGoFTbuxQGotwJEbAUgBi6+8ZBKQOgygUE
 wrCj74P4xrAULGdzzOkBr6b/cFmjQpNfcDZyg9eoSG4nGghCAg1dsOam80PQ
X-ME-Proxy: <xmx:qaLoauLQTSyYoTvDMgDmCMrh6eeMq_2B6KmLCNq-FQ1MsqF0Sw29-Q>
 <xmx:qaLoaulW6JuERUqLL9d6iRciHJM4CC8G7XjPxE_ogg8SVEhVcrnD-Q>
 <xmx:qaLoavLGuzBWuGZFiGplwxpSCUvDDJXOIxPvwo44zrT4Ko8pSH8g0Q>
 <xmx:qaLoaj7wPh4tF7UPx8RG0kUVzuxvvtRoVxWs_x7FtgZG5Jmk3teBcw>
 <xmx:qaLoairyRttgOxUZbai9G4kljROOMzVajtEO7Wv_LblGeB5W1-RvmHM9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 09:48:08 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: vladimir.medvedkin@intel.com, Robert Sanford <rsanford@akamai.com>,
 rjarry@redhat.com
Cc: dev@dpdk.org, stable@dpdk.org, Robert Sanford <rsanford2@gmail.com>
Subject: Re: [PATCH v2] fib6: fix sign conversion of tbl8 indexes
Date: Mon, 02 Nov 2026 15:48:06 +0100
Message-ID: <xMD9Pxb4TvSxlDemjuTrhA@monjalon.net>
In-Reply-To: <20261021181848.3850548-1-rsanford2@gmail.com>
References: <20261021172030.3824657-1-rsanford2@gmail.com>
 <20261021181848.3850548-1-rsanford2@gmail.com>
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

Vladimir, we need your review on several series from Robert and Robin.

Robert, Robin, please feel free to review other patches pending
about RIB & FIB.

Thank you



