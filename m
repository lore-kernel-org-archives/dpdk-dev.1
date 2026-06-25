Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00ACDB47C
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 02:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7767A402A3;
	Thu, 25 Jun 2026 04:32:41 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 4BDB940279
 for <dev@dpdk.org>; Thu, 25 Jun 2026 04:32:40 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-139aff562e1so2428457c88.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782354759;
 x=1782959559; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNIBuvRtYDNCBlu+wbDnsqHiZtNzN0Y8qdlZS65PsDg=;
 b=iZS8K7PC3wDnq2hAbap8VJsb6szi36p1Lmp8AGv/Y5HN5lKzLN4t+BIRTgw6ILccUf
 RFrQArveh4wx8il95FNyaGdRkVQErq9/Ds/8+VvXgRYY0CzlELSXsGLNNOhrk3CMqTYl
 jPXxp4nxECwcWKofR+lAhbvnKorajyYVBWSYRRKWF4ktkSvEsAHoHsEqJK+C47D2UR6c
 IMwG86R9r91RT8OUOoIs7Vuimn7fDwJ8BbP9aYgcsXuZFRzarTFDb0MdkkDZi3irAJzZ
 B7Ua8gz/iTUeE80TwI4pEc4cTKNduuipEFl+HXjOf1Z+l+DKJ9BiL8LDI3jz6JJg9oWH
 U4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782354759; x=1782959559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BNIBuvRtYDNCBlu+wbDnsqHiZtNzN0Y8qdlZS65PsDg=;
 b=CmgAQqCxCrREXSu5DpNpOMmxCDyO9y7zpcPStahJypxukC6QfLNQwkkuOykf27mu6O
 iGjtakjjg/aE9vuzJLIIaonFnQCddS37WgU2X7dDEleDIyyIg44XLRA1liLwJOwjxtPl
 h/XSrgfZzqMHx8XvMANcrsNVu4x0z2U/wpfhf/bY3mPNtPhsKhgLpehjt5lgA1G/xS5k
 +Et2v1ct1ulnvMmNIqf2qkFtJlhy844MiIz4WjU5zvydhmZz0t1Jd4dcMFav8cYkklrS
 xLaZyEzAML6w1ZMblWCwtw4JmFAe1j0otN4wMf7V2mu1cfIxxTA4vcVxfC83qMQbfWH7
 fFvA==
X-Gm-Message-State: AOJu0YzJ2Tbb+OvKWwzuEhF53v9YiRPFEbwlNdFOnCaVRZYIiUC8X6wh
 wv+fytZJSmGxo0zrug10uprAZ6HPWzmIwgOS04Ou/IiRyFy317eNYgBJLoTrs8nOSuA=
X-Gm-Gg: AfdE7clbDEQfzP68sg9i+5jTiPwvKV8J105u2JyqPYJY57mUT5e9UnZMc2J3DcvTz8I
 T7psjX70tilas47bvLoHfbOLNTjO6seRTuJ3ZrVtivTNFaYj/oZuRJmvgTXhuJvriXe6sBDJfcQ
 cuyoKu33EvqYOBTDdLwSnwjkewCtsurpyWOpsq1Kip9kYpKe8Rqpm7h79XBNes1YgHj1tBv/s5g
 a3jaJbFjU4/srbgmCk7sa8nYcjn0OBuDJe21jXCcwRYWzvn9S2HWXB2S0FFAbJoBMFVNS4iPF0F
 QzrOIpdFTveQEJbz9LzCnaOBbssGXt1RH3bJ7ZkX94lJ9Zabn2rgpq+McAd39OOgirep1VUDBEd
 /8gcD1BkK/wr5HHBp3SfDB4XVEdooh5LLfjFog4iysvScXT+D3a/a58pH+hhYhy8uKqYUKTinc0
 o28Atct911re+r72BD/HmHQu8DzE5v2owM/64tO76tcCYDk9Dka3ucvglfQ3XaEpTu
X-Received: by 2002:a05:7022:108:b0:137:fe07:8a2d with SMTP id
 a92af1059eb24-139db9e8337mr633664c88.6.1782354759094; 
 Wed, 24 Jun 2026 19:32:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm3266531c88.6.2026.06.24.19.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 19:32:38 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:32:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH v4 15/27] net/netvsc: replace rte_atomic32
 with stdatomic
Message-ID: <20260624193236.3f7755fb@phoenix.local>
In-Reply-To: <SA1PR21MB668328954F3A75443CD9AFC9CE082@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-16-stephen@networkplumber.org>
 <SA1PR21MB668328954F3A75443CD9AFC9CE082@SA1PR21MB6683.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 27 May 2026 00:29:55 +0000
Long Li <longli@microsoft.com> wrote:

> >  	do {
> > -		rid = rte_atomic32_add_return(&hv->rndis_req_id, 1);
> > +		rid = rte_atomic_fetch_add_explicit(&hv->rndis_req_id, 1,
> > +
> > rte_memory_order_seq_cst);  
> 
> Does rte_atomic_fetch_add_explicit() return the old value of hv->rndis_req_id? If yes this is not correct, as the rte_atomic32_add_return() used to return the new value.

This is a request id, it doesn't really matter if it is old value or new one as long as it is consistenly used.
Optionally could just add one to the result.

Also not clear if sequential consistent order is needed here. There are not other dependent loads or stores.
