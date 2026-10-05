Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF39CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 21:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B300D402DD;
	Mon,  5 Oct 2026 23:38:49 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 59BD4402DA
 for <dev@dpdk.org>; Mon,  5 Oct 2026 23:38:48 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AF5FD140018A
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:38:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 05 Oct 2026 17:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791236327;
 x=1791322727; bh=ZtQTD7pQE9mfV/0e+beXTVS6fBBlsAVJgtgLfiGt/HA=; b=
 bb59XBCmn9jq7Woh+1GBw3wMoP8VBotD5t/+ySXS2SqiZmVBCKye9cCIn9HFpng6
 oFKo5EBmizg+OkaFwZxoejsygTZCd2V1iV/RFKYmX/gad3IJ32eviwnJtFBZ0k4D
 doUus6Mofg1hJWUhdYEBaS15zfvpla+SKzscnNE6uIqH4U4wrBhyzlaoEdiGgJG1
 oT0q9odiX3C/PdnYOELrRUMPy5krJa0oCItF4rPY8oEGxT7LY4gZ6JJ/BS6O9jbu
 2JVsy+/RjE4ZjoCFiU2Ta9je231F0wCKdYoHrmgd6U7dTYQ5AKOspikVFRqJMx6l
 Zd2nprfY4zdKyX0D9lS+Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791236327; x=
 1791322727; bh=ZtQTD7pQE9mfV/0e+beXTVS6fBBlsAVJgtgLfiGt/HA=; b=u
 CeFICPXhgAqTAz/OlWwdNDoy4Lh1o50KrobegbUj++mDlh5qr+/M2zO9LgvZSS6z
 uJEkjuskjDNb3QUXwQQ27i9SB8GdzZIsU+WH+aLCbUEiH1NX7a97OiL8ERi/osg7
 JCYzc/ShtNwYqhc6N3CPKGbTMNakwu0CgdoXzSBzuk603ue0BEONkRwEBICINvMI
 guAtR5lSDYxrZ2dGA6zLeC5vN6mK0YyUkzI2N90OXCMIpRXFZQ4iCuVG2vBZ89V/
 JEDi0yfAYExV55ruG96tzm8QTcmx4twivf8xhV1yWuf7X8HVUElVJLBuCIwkV+bm
 760sFctfGnnR62Mc3yNYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791236327; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:b9gdkxhALg88SfhwnpDlNsr5kHeS5kT0kVKb3QL4qzwqeoT
 8jAoUR82uad1XlOM027Mr1gZdHifkqSBvW2LRb5gS+gypmqMGqTOpPx780Zjm7sm
 bYxH6shyruKfcA26gOB3uHZhatdm5D/xZutacIQd+iVrJRdjYgTv3+62bwJ4bdIA
 dSSisCFBXkz+sAs3OSNyeNZw8qdVpSsaCgWPwLbNn6+oClZsMPAk5MBqwA7XXBJK
 +9OnS2hULlGKZisMlG3M2BdZVGBEKqocfS7TN6HBAFjIQjF/YTZrd6UVdy8nb2DG
 IyK/0ukf7QzFPv4+3wuBDBoDprtfP00XTKr3gNw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:O+s4KREmi9ZEXSlgjrXyIk5AtOgv0DBFSi8nKKv44Pc=:ZtQTD7pQE9mfV/0e+beXTVS6fBBlsAVJgtgLfiGt/HA=;
X-ME-Sender: <xms:5xjEapZ_8nP9s_aHdWIzwFSBHx1p6F1-0E9vula6frFdixeGLEITfA>
 <xme:5xjEaksCwYwXWap__txe4qyx-MlXVqpEkxb7zolQJLDqGcG_moB4Hj9uUjvuSRikc
 qneO7fJ_DVRZxUm51hyhtJcL7xKjSSYXd6HLODv2RujTHRWktaL91w>
X-ME-Received: <xmr:5xjEarEO9liBL0KctCthwYxgq6P580kGTFORIvkPuD4T6o_tNcT8ItimaE3iyCDHPsVz2rfhD7bPXIasaHK-yWE>
X-ME-Proxy-Cause: dmFkZTFy2WtW6KJJ0ULPOOWmq+mn2l0QGVjZtMtU0SeuypwtyXqc5n/p0SIQq/e6yWXB0l
 fMRMTrRTVR/zDizjjDj1Q8GS2d53FT0PWXWdXzBMT4htY2deP3sgm+hSRQsJXbe0ti15gm
 NXBVzRT72N5WQOTFAxer1IlGSdTEaeGvWbgj18AMDlIZ4AV0EM+bsWDi5T9Hhp/jpd9l4+
 obP3YAoLRk36mv+XOIVu3+ZmtnK+DPODyPTLAkKwXFKKXOXJq63WqqKtVDkTjGLU1as84F
 6ionCiVgp1+62aEoLtMZqFFukhBmqN8BIrPECLwy9SWK4CCP7bf4U2x8/rCHsUCIl3lGM+
 DBuMF7Jpw/hcAnsbGs6CtoPN6RV29Blsfwb37xdUAjhhSzCg8S2RGe1YxUv5AMijf7MQfc
 zR4SnjU0+90+96AvG0fZ0bERjWAx1xkYgY4q2Q7DIabQtSOHmTequB8N6kCq1ngtkSHJ7G
 Ft7r9tteJLpojRLaZ+5kiMeqcxKVWKZOaNbzLKPv/VBLps75SvDoW6OUMcI12GOFYMe4aO
 ZB8CBskrcCmUzdZnjQb+7a6HXrJ2nd7SxfNFjHl+N4x+a7uwXZB8uAs75bgWwP+Fx7pwbH
 Vr/1xV4WxmmMwwikiDgqIMrFdn06zzz9h96nMxqPoQk6ycxCFx2RdC2Sh6+A
X-ME-Proxy: <xmx:5xjEavw-9aw1_DMMhWOstkFyF1IFymdTD0YqHPknWiKk8VbwBZAMRw>
 <xmx:5xjEaqhB0MfPCDwSdHU2se0pQI_db9NNIxqYyN7B2gM523pvVwxdbA>
 <xmx:5xjEaixoU04wROqV3qkAoTNw6vEy7bmMh0BLerdRgCidoqftiVO_KQ>
 <xmx:5xjEalJeDOR-U2SI3cshcbvaclqMrKEsnjPRMPLmvfOy8rWUjP4SFg>
 <xmx:5xjEanG1rOQlsvLf0Oqnbc7gRpgK1G9dYaAyfscv5-GDhQowWyY8V4Ro>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 17:38:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: techboard@dpdk.org, dev@dpdk.org
Subject: Re: [PATCH] mailmap: update contributor name
Date: Mon, 05 Oct 2026 23:38:44 +0200
Message-ID: <8457YcUwRNKkP-77iOTCGQ@monjalon.net>
In-Reply-To: <nLiq8zk4SyuCC_MjhReN_g@monjalon.net>
References: <20260927035949.36887-1-zhtfdev@gmail.com>
 <c846b990-8b40-488b-95f3-c151aa9c6b9e@gmail.com>
 <nLiq8zk4SyuCC_MjhReN_g@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

29/09/2026 15:30, Thomas Monjalon:
> 29/09/2026 01:12, Zhang Tengfei:
> > On 9/28/26 22:33, Morten Br=C3=B8rup wrote:
> > >> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > >> Sent: Monday, 28 September 2026 16.22
> > >>
> > >> Hello,
> > >>
> > >> 27/09/2026 05:59, Zhang Tengfei:
> > >>> Use "Zhang Tengfei" as the primary name. Both addresses belong to me
> > >>
> > >> In DPDK we try to always have the first name first.
> > >=20
> > > "first name" -> "given name"
> > >=20
> > >> I assume Zhang is your family name?
> > >>
> > >>
> > >=20
> > Hi Thomas,Morten,
> >=20
> > Yes, Zhang is my family name. In Chinese the family name comes first.
> > To avoid ambiguity, I'd like to use "ZHANG Tengfei" (family name in
> > capitals). Would that be OK? If so, I'll send a v2 of the mailmap patch.
>=20
> It is a discussion we never had in the project.
> It is being discussed in the Technical Board.
> Please wait for a decision about how to proceed.
> Sorry for the inconvenience

The techboard has decided to allow any ordering as you wish.
No need to have your family name in capitals.
So this patch is accepted.
Thank you for raising this issue.


