Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A8606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=Ykg+9nYe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OGiZSHuK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D55FC40289;
	Fri, 30 Oct 2026 13:59:06 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTPS id 8730E40285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 13:59:05 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 713D1140019F
 for <dev@dpdk.org>; Fri, 30 Oct 2026 08:59:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 30 Oct 2026 08:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793365144;
 x=1793451544; bh=f+jk1XXm6pmo5/Hx32+XKIQLKrmGUlTMBYD7J98LWaw=; b=
 Ykg+9nYeATfS9urgk14SY6f77x6ZM4ObI8abblfDS7wBgxwy7DJjdulOGhY60H0a
 xpVOT0+PQhGEpwLQoe/QuktiokM+9NoUsYa1f+jz4AuxB9WPMwUzeTkT/V0ZSSDc
 8GUoa7QQdhgMyYq70AcrQxD49IM6KBoMvDrAXCZX5E+1th6bSHd05Rb9jdbPu3J9
 2Okrz7ctxExQq8+jBhEh5RP7NDJSNg9bqvaK6c2Yt4azzpY+sUudSvRXF8V+/5VG
 3DN77eDdJjdyTxTfoxNwTRuYdWoWDeBIpSFTHwnjm42B8tHObU3U83XX2Dcb3iR0
 8Rliv4OU8t6qe240PgIQTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793365144; x=
 1793451544; bh=f+jk1XXm6pmo5/Hx32+XKIQLKrmGUlTMBYD7J98LWaw=; b=O
 GiZSHuKEtSWXs6VuGPiAWybEJ5P8pTZT0j+maelDTNoU5ebegtd6qoZmOnMUxs7l
 7iQKjYcyY528vyJyWzRFlGLQ0E2eEwjnztwQf5lk97XIm3Wv/uC1oRHCTykCRP0p
 4xHO0KUDqxsd8hN9TzuCtCj8A+3hVZ27mN2hH33s5GoBUjfdpdOBmzeEDB8fSt1A
 pdONOwbGzd0kBBEQ6IIVVfPRieCJ/MI+qae/zApNGqM5ioB2fYJmIKRWQTW5mJ+R
 ZEessshVtgkaQINTr4XdyHKPisyNSmfoZk2f7OSeQupPFCz/oSb40C+HuqiU0Ref
 8mx8OHAjUuh4+ebkhA/4g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793365144; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:oWYreho+TSyjbDSsICF2Qms5PV2p2LYs1istppnj6a5oP7q
 4a9WF2jaNJmhU/I7EanugAOsX8IPqkVPRkvxT104ZRmplAVRDPJ5mOAJceppY0tz
 SS6Fz0UQXqMHAmuq2liGLrjCJbFKMppk1Tmr6FFixOQ8DyEm5CLaIQMjUTMvfiYD
 cbrAaHbcFSY3db+AgnswVwcPUdhOyacpKKlf6SCJkoYBR2fluZvxKT/ULQ+eFqnA
 IG4Y6fnQLx1WQVpfqySi/5M7f0be/JxfLCMUPtjcfM0NDSnqIUs6bNn+t3V7St+7
 IZTprHzhS1JF3msKIj+rnF6Ce6E2+aMrpdBD/eA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:gvxTKLDo0Qy1Y2ca5i4SMU+KWaXw3UqiGDVIz7SerWI=:x5iMZo4eH0bWSFQ7a8kYRw/SCsF6SI7OBulxntL5dZM=;
X-ME-Sender: <xms:l5Tkakgru8NkINHs_v-8rCK5Xsji71e9Pnk9V2avt3udKrVmnCkcuA>
 <xme:l5TkatKeheB1OaXeBy3V78LWd5xqPb3Rkxct_k-W98hiczgIBvo3b8i0hvmFSdYBp
 ChTu7ZdphVF8JGwJXiCaFkId7gs6zs7vBNKM7YwYoTDsmTITjJ40w>
X-ME-Received: <xmr:l5TkakBVAJnD-SAozmPWCffSxLUOdTpyUiMuBQe80j6-l-qJLiyDxpTJvgGrjpD6nDhaKm1YfOnmSbbTp9YeaZ8>
X-ME-Proxy-Cause: dmFkZTEcWssIfmNaxHwkFO0OytBC7kxOEt36WoSS5Bf68Lw4XPbpIQwilyARsQChKTeQwE
 n1AnJflDtzUuxq9/B2ayikY3u8iEH//0VTD9PK9JlBkusmAUCGxw4c+lku+uFRPB+Yu3Ut
 FyXglIZJy4a5G5nPsM/ZSyedlL2M5NTFr5gBjwsGUj9yygePtuKaUmTINpr/aXmn2xN0aZ
 jDq1tSBauJ7Zu/8jricX97QoEObPYmJDGoY9pVAriu95KNjAUXOsu9AgZNLQeeBWjxZbCW
 OzLvWkVeUy/hPPschg7UDKXR3wzoWlNd8nuCRwnhtYyt19NIlfVByH718cZhzGE7o3veE5
 kr3v8m3FEyGYZ7SNRRfG+c0zzDQSbm/lyu7uk8ngqSxD5JUNlSxMMYhSwB5oP7IJSQPZG0
 Wl2SX/DsscIpywsyGJHPd9HfTdWzZOsKUy2fHPcce6EQXaQriBui0Hgg73LkvegCEoEDZX
 cpefZv2K2IbGlt/lKUUHuG+OJy0b1wBl6+JcheZ+wiEta3bkOytwQiUX5x9nEh6Ngg8kqt
 +BAMaldjB2zfE6cmD3lyfQPR5/r5g9KKLiaML6ortxdt8l5UbRSObgP59haeZE8r5+eBcD
 GnKMRxIZHVHrHxbL89EPXy5kLUiCQs22ED1IWmd+BqgYBAjom8TIs6Fam+gg
X-ME-Proxy: <xmx:l5TkatiM6uuL6t_R8hc8orp862xRzJxkOcXTkMpyj-rAW96xd7q6eQ>
 <xmx:l5TkaskVcsLjHJtw3Hcu8l3ThfOD1RVVlAkiUNwW2yo1HyIPmrwOlQ>
 <xmx:l5TkaprqkYZTSXY97ztzKbKhQK-BC_ATFG18bxURrQveaagtetT4PQ>
 <xmx:l5TkalF1IOTldZRyGVE2qodujw5W6kG_1g2sFFPxMIQ2-CdUbdTKlA>
 <xmx:mJTkasxXQ2w9NZ8Es2DyIs0i4lV07sqzliK7x3RRv_HtB6i1OVUiUAjY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 08:59:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: fengchengwen <fengchengwen@huawei.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: stephen@networkplumber.org, dev@dpdk.org
Subject: Re: [PATCH v3] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
Date: Fri, 30 Oct 2026 13:59:00 +0100
Message-ID: <xvTXknUbSMSD_Fg-tQD_aw@monjalon.net>
In-Reply-To: <01008a9c-7217-4a3a-a633-b89ee4c97d65@yandex.ru>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <c42caa92-ecd7-4e78-a864-a0ef451a9f61@huawei.com>
 <01008a9c-7217-4a3a-a633-b89ee4c97d65@yandex.ru>
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

30/10/2026 11:52, Konstantin Ananyev:
> > BTW: SOCKET_ID_ANY seemed need redefined as RTE_SOCKET_ID_ANY, If there is no
> >       objection, I will make the changes in the next independent patch.
> 
> Yep, that's probably a good thing to do, and probably 26.11 is a good 
> time to do that.
> BTW, I think it was discussed before, but I can't remember why we didn't 
> fix it so far.

1/ We should not break this API easily as it is used a lot.
If we do the change we need to keep the compat alias for some time.

2/ The term SOCKET is used in many places instead of NUMA.
There is a confusion between CPU and memory which deserves to be fixed.


