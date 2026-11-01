Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C5606A324
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=fHsODiES;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=sLTNiQkQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B688C4027A;
	Sun,  1 Nov 2026 15:26:26 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTPS id D01DB40279
 for <dev@dpdk.org>; Sun,  1 Nov 2026 15:26:25 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id D3BB2EC01C7
 for <dev@dpdk.org>; Sun,  1 Nov 2026 09:26:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 01 Nov 2026 09:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793543184;
 x=1793629584; bh=OEklmuET+4fudcjn+2LlBL8jzGymIir0maXAHshrawo=; b=
 fHsODiEShFYRiRmA4CBSg+hNbVe1sdtwO83YCKdpteLLp4hL1Co5eXAAWB/qZqmg
 r7P7jBziG3Sx7xYnFoUB3daqwJtxhu2kv3JnPHP5tJRJvJ7ExIs4xgQRJQu0GIFB
 VecsfgQUfNgj65FYISWdGDQCDRacXtqTKEoFQCExtHNhKN0PNSxUf6HlWkmgsUpz
 UcWMMHZjTULqrkUQZkx22TeI79SRoqzlXUUFmugq60DlZc5iclECGGBrpUOTQx1A
 SkvGyvKLJmHiuW7vj24wBKa1NNb50PW9CCHqyEBM6yWOvMHmyS3N68K+3PRLK+Gc
 Qilf5wseKpMDW0xtkSISGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793543184; x=
 1793629584; bh=OEklmuET+4fudcjn+2LlBL8jzGymIir0maXAHshrawo=; b=s
 LTNiQkQtPNInz/PU9I3TLfPjO+m7yRJRAwtwfV/MqRyVqNQRG8rkk4rABE22d64D
 8c1koL96Udxg8x7lkKYqXQ9T1mNKuq5U79KG/iYjktkrCzUgCYhJ4GjHgOqK8bPI
 CDp2U8gFpreJcqs3r3N1s6aU04u1TVaQA1HxnSOHC0cEWH6ZqKLCWuJfK8ukZiqo
 2Rzz8pGCCFDN7ve2gpX7BWgO1Tv6KnEcjebfMNVi517YP/UEe36lRfpNiEUX1dYG
 JEyayx/7kbNT0r2owoshzgnJeEFJez+mxvtH4RViSLO9tTgGXlZVLc9fGxT2N8/+
 USDb7s7Br0shTy9oszTiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793543184; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:jxbrt5MA7OeoIUQjKX65LY2/BnncAU0XJTmDV5rgZ6V60uZ
 w63/1+TWtaQcOQmtmSTxCNiQGZmKN8k12Lc/mmmRsPEKnQvjoQKl38FZcIJrtKqh
 N6qwIpUv7xXZMa5QV7q2bT0W+g5D8ilu5LT6JxCc4A2TCD82Qf3eOp+X1zErN9It
 f4mkzIjiEKpa/JxX5D8BYpgUfrfTiNOyY6PlBOJMVHm5TEqMQIyLPEbOrzPZ5voW
 7M2ZJLkmwwYEZbAljwafqYwS58uT9kPm9DB0gdjQE0Kk0nq3luHuiPknBgjoiDVu
 lPHzUh5zdqKULASL9osRGRekuJO/m5FwhuIbK8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:IIWpHWWHykHK55YYr0YzJQ0JvbBvGImb/pwaYVpsjd4=:nObdiJiI2p0r9xBIF3zfqtlC2M1+ckah4W8kZiJA79E=;
X-ME-Sender: <xms:D0znamVo80Lag7tuQGvOqKH_v1sfow6gw4c6kZVyAklKxJnCSnESMw>
 <xme:D0znaiuyGw84poEneOSe8zBkC-lWVeZJmhppn9Qf1oJLNrG4RX4ktKKjebpoEDPER
 om1mqM11-1p0caoHutNsqz1863gb2U1BjgprlHGAgRMRY9E8VMMwx8>
X-ME-Received: <xmr:D0znaiWIVEjNPu2m2QTYykundiy5m2oOAGDANUDzzFDw8A7wljmxhbWmQbbCJg3VdhJWiwGt1dM17m0ivQ>
X-ME-Proxy-Cause: dmFkZTGQFypPAJWWjLoo5lRi81J4G8KKBQ0fJ6OV/mrX7SGJhl2sU4rqBWIE+KweHYnzIX
 pf4N29dGcNAV7eRb76fJSqU3O0by4tCH+GsOz8RMISbA9LK4nSPT6Sz4NOPAwpwMb9eyh4
 qc7dT0dCEPFWaw/ufiQwbirPoTivOtKuwA7dVnnxUiQmM3c+F5Rg2RyX9ed7uI25LqTcEr
 J2wToDo5OGx0sVc4NMeuUTPn/GyT7viEbT4PIi6o2KU17F4heuXj1eqBTf3veUgp4h1jos
 6TTNfhc2QeWCVOpgFE4WFsKTktzE1jC+f8k7TKHDqU2X1EH6d03gbxIiCVLNSjB5HYFbj1
 fs6lyeGOJwXiTKYoc2br9MwXk+i8FGoMCiB2l5m9dHrkWbHl4NUwVJJ3d7DBlmWaiNO4ek
 kPgMMj87YTMDx4CwpEtqpNw9zHTnG9n62d9K6w7OYmXMrsfSxBhtZj53TGlMzA8rrW6iUf
 HfRG0puE1qKgXvFwVO0dKxlB+w7dYyeZ/rWyC41ItIlKrDyVYphWsEtR54J7G8Rd6D9wDj
 q7Ygx8+InxVvhj42IOwbe99ozxIgSlpdH8I+CIYNAwVhS75xj6X5aRagBTQth3cLue1vQR
 tUQzyXugbYUIm6NPsgCx7VR7G8+oRbvUYJvnIBX6mhHFFzg8/QXzyTkyvVzA
X-ME-Proxy: <xmx:D0znaln2mbnoP1VJlHSXG2qE_vvJGnWalw_eI_4_jVWm7YLhVIHHQg>
 <xmx:D0znarbn1w_EIqJ3Vm4tGWyM9mI7_SavbNPpjrZ7862r0kQkqcruAQ>
 <xmx:D0znaoM6AwKWY9ra3tOKCaP0WwyooYgOucawnF-pq_P07jUsH35hVQ>
 <xmx:D0znaobR9vlC1ooTrBFV7KDD3xuiUuSL8BoOloeSy7EdY8-AoLwWRQ>
 <xmx:EEznauHheYY2HajqVa17Ukz8M8ZXAgjdp775I5nX_zclFUXDhx0Ss1W1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 09:26:22 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 fengchengwen <fengchengwen@huawei.com>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v3] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
Date: Sun, 01 Nov 2026 15:26:20 +0100
Message-ID: <ksiekRtOSqOSIIkKFdXdAw@monjalon.net>
In-Reply-To: <4687e093-ac82-4ac7-aac5-838be6c52433@huawei.com>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <xvTXknUbSMSD_Fg-tQD_aw@monjalon.net>
 <4687e093-ac82-4ac7-aac5-838be6c52433@huawei.com>
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

31/10/2026 02:37, fengchengwen:
> On 10/30/2026 8:59 PM, Thomas Monjalon wrote:
> > 30/10/2026 11:52, Konstantin Ananyev:
> >>> BTW: SOCKET_ID_ANY seemed need redefined as RTE_SOCKET_ID_ANY, If there is no
> >>>       objection, I will make the changes in the next independent patch.
> >>
> >> Yep, that's probably a good thing to do, and probably 26.11 is a good 
> >> time to do that.
> >> BTW, I think it was discussed before, but I can't remember why we didn't 
> >> fix it so far.
> > 
> > 1/ We should not break this API easily as it is used a lot.
> > If we do the change we need to keep the compat alias for some time.
> > 
> > 2/ The term SOCKET is used in many places instead of NUMA.
> > There is a confusion between CPU and memory which deserves to be fixed.
> > 
> 
> My plan is a 3-patch series:
> 1. Add RTE_SOCKET_ID_ANY and deprecation documentation.
> 2. Replace all in-tree SOCKET_ID_ANY with RTE_SOCKET_ID_ANY.
> 3. Mark SOCKET_ID_ANY with RTE_DEPRECATED after in-tree migration completes,
>    so warnings only hit out-of-tree users while DPDK itself builds cleanly.
> 
> I will avoid the bigger "socket -> NUMA node" terminology refactor in this series.
> That would be a massive semantic change with large churn, better handled via separate
> RFC later.
> 
> If this plan looks acceptable, I will start the implementation.

My doubt is that while introducing a new API,
it may be better to apply it in correct places with correct definition,
avoiding mixing CPU and memory.


