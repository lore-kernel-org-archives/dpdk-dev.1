Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295BCD3445
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 15:47:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F3BC4026D;
	Sat,  9 May 2026 17:47:02 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id 2A20C40269
 for <dev@dpdk.org>; Sat,  9 May 2026 17:47:01 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so40837c88.1
 for <dev@dpdk.org>; Sat, 09 May 2026 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778341620;
 x=1778946420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mW2ls89x6w0RYoL6jA5ElUsABLSsTfHZT6zHfKgxYGk=;
 b=IiEDm3ZTapY4M2IJ5prJW5p24Rc0ZyUegi+ewNDCvmVLhd5Mimo4GSuroz0Z84YBHC
 1fTAYm0tFtr2Fj5CE2da+TGmYCn+4UfAqQ9XEIx3vtuPJJf8st95OjtQgSro07ntQMYr
 8vXu2oLXdq8n7aBarl8kVdKZrcv3hVzgvfaHgbVfqnIN6wOwCbv3PePY0mnB0GXQkzcz
 pQKqI643wZkWNoSjxAX2CrZGtM6m0FcK5bUEwV9IBgj9k6vNhQN/U2jStnncw4ZA0v43
 fk+S7b4HN/E6mq/Ome3qGVnkPkNNdwyonJlXGMC7QnwFYpGhvTg34IezCtPmQji8Ay4K
 6ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778341620; x=1778946420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mW2ls89x6w0RYoL6jA5ElUsABLSsTfHZT6zHfKgxYGk=;
 b=Oen/A7abghxJC6h/39YGDSuf8wkXYS542X1XCsGtoHmafesLX2l3xoTCyCZwGcVpQi
 oR0PWiVwBWkxltOdMehFM9cvH/RH3tKR4/yRjalXigEuxVJHYJvcJKhnWSZswyMuij/3
 lZumlEH7xXilSJ+o2KA6uzk5PgKz6ZIx39JL4Xfzw0IHzzfeG3W8HvrOdsdj6adBorsv
 yi1P9oMAwkyQ3p/AfoHhyAFSxXTL4vo6JH29flZfQacu0v1t3DBKyJokipCjcnuNdE9u
 UfU8WG5Wn73j/HdnrxEJ2HSagqeFzagvwe9e/jom6csVjZOYB7HdiYIySR9eba4MLwtp
 P/Hg==
X-Gm-Message-State: AOJu0YxfOrcima56ij7KNmxCx6GP72uQbn3RDE5OjyZ12bGoyWWVUjE7
 rsD/eaesEZ8MeVx2zjX5fnCVnJ4/wn7iA4mRJuBnc/eSRdX+LmQpmnA5nYeS1/1FN84yjPyC4Nt
 LPE4m
X-Gm-Gg: Acq92OEHL3YUdAOP44ThiFyk67Ir8iwBxuNT4upaYTW8jQYzRqQVSo8lI+FoJhzuVzk
 HmDz2GAOgr+Y/MGGhWegZvAobV5wWDB+RqKc6W4byucqeW60/zQ81If/crM/U/RYTyCkeJMQDt6
 W87NDMf15wVGlRxWWIw4BYMezz8QUHOAaSk7OhX/ptxRwgEWsafZDe0t1e1Y7joEv3QhR5fokna
 fKR3cDweeRG7k+hp4PS8c9EB0Ql0h4tPNdN3TGNH68vrS2lNqGOkY/bsj1l0w9kQN1sEnZhsAtL
 BVCo7+njHT0rnYdk9DVsgmEbO9SDTZmiBUv9YP9bOlzlLZRk3WJ/jmCpuzNcp9/CLgeyryWZWMo
 6KA4+N9tjm9zmFmlN1pAWCHo1Iv8Wxf/rCSL3Q51rTSVd7YH84Wr7WYWGDld6DRRV8g9xSgqZRo
 UJlB/b4zLIoJP7jg+VInEAIS2zYZou9EUol/4=
X-Received: by 2002:a05:7022:ea24:b0:12c:87f1:f41a with SMTP id
 a92af1059eb24-1318e91771bmr9204156c88.21.1778341619943; 
 Sat, 09 May 2026 08:46:59 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13278758e0csm7299986c88.12.2026.05.09.08.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 08:46:59 -0700 (PDT)
Date: Sat, 9 May 2026 08:46:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH 13/20] mbuf: allow NULL array in rte_pktmbuf_free_bulk
Message-ID: <20260509084657.598eebfb@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65869@smartserver.smartshare.dk>
References: <20260508203607.1003036-1-stephen@networkplumber.org>
 <20260508203607.1003036-14-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65869@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 9 May 2026 10:47:53 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 8 May 2026 22.34
> >=20
> > This allows callers to avoid NULL checks and just call
> > rte_pktmbuf_free_bulk, similar to rte_pktmbuf_free.
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org> =20
>=20
> I disagree with this patch.
>=20
> The parameter is an array of (pointers to) mbufs.
> We already accept that the array can contain NULL pointers (no mbuf prese=
nt).
> This is extremely forgiving, considering that other fast path functions d=
on't allow NULL pointers in arrays;
> e.g. rte_eth_tx_burst(), rte_mempool_put_bulk().
> But since it's a "free()" class of function, I don't object to it.
>=20
> However, this patch changes the parameter type from "array" to "array or =
NULL (no array present)".
> And I don't think we should change the parameter type; it should remain "=
array" only.
>=20
> If there are any scenarios where a non-present array (NULL) is passed to =
the function, the count should be zero too.
> And when the count is zero, the function does not dereference the array, =
so explicitly checking for NULL is superfluous.
>=20
> We have a convention of not checking parameter validity in fast path func=
tions.
> And I consider it invalid parameters passing NULL with a non-zero count.
>=20
> You might argue that this is a "free()" class of function, which warrants=
 checking for NULL; but since it already accepts NULL with zero count, it i=
s already covered.
>=20
> We could change the function declaration for clarity:
>=20
> void rte_pktmbuf_free_bulk(
> 		unsigned int count;
> 		struct rte_mbuf *mbufs[count], unsigned int count);
>=20
> Or add a debug assertion at the start of the function:
> RTE_ASSERT(mbufs !=3D NULL || count =3D=3D 0);

Ok, it was more motivated by common pattern in driver cleanup paths like:

--- a/app/test-compress-perf/comp_perf_test_common.c
+++ b/app/test-compress-perf/comp_perf_test_common.c
@@ -83,11 +83,9 @@ comp_perf_free_memory(struct comp_test_data *test_data,
 {
 	uint32_t i;
=20
-	if (mem->decomp_bufs !=3D NULL)
-		rte_pktmbuf_free_bulk(mem->decomp_bufs, mem->total_bufs);
+	rte_pktmbuf_free_bulk(mem->decomp_bufs, mem->total_bufs);
=20
-	if (mem->comp_bufs !=3D NULL)
-		rte_pktmbuf_free_bulk(mem->comp_bufs, mem->total_bufs);
+	rte_pktmbuf_free_bulk(mem->comp_bufs, mem->total_bufs);
=20
