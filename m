Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC28F9EDC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 13:24:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF0EC4065A;
	Wed, 22 Apr 2026 15:24:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9F0C8402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 15:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776864243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttID12/9hB8lKkUbEqrxrux0X/bWDHhlHIHXACppy2k=;
 b=ASdw3avjcEqhY2Fs+UqHJe0jAvyLNHVJ7xcCJKuI1XHyu1nDus8hHJGO6c10XV6wUAOhEx
 BCXzetk3SSuYYN2EvA8QDWisl9jQ5bsIoB7XLI/28EYkDr75jmmVi3NC9QitdOemumVozD
 3+ztQ8qeG1RMc59LqqmahQX4nTzhFRg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-qoWu74lpMoCCPS6cOKevmg-1; Wed, 22 Apr 2026 09:24:01 -0400
X-MC-Unique: qoWu74lpMoCCPS6cOKevmg-1
X-Mimecast-MFC-AGG-ID: qoWu74lpMoCCPS6cOKevmg_1776864240
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3870692eb93so33471761fa.0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 06:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776864240; x=1777469040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttID12/9hB8lKkUbEqrxrux0X/bWDHhlHIHXACppy2k=;
 b=WpFQlFKpuuVfD9Y4yyhoFVRDKXt/3LPhsGc5KWXT9BkBXyyY8U/YcmysW8BYowymSK
 FC4IOoEX/yE456e6ClIUT1q7aagKkPaPAi0rb85jtORXZagBuueHRmdCQPFU4ImykHaw
 mVV+Qjc6SYJoadd2QGqoZfCdx9yjTiftHdPFty9WFDzAddQp2YbmXyjfxYLwktSPcLxM
 DDBxhE5NU+bBAFecWjQGG02RB8A6D2dWE78hbUeD65kPDxvdFp0GqPddcgUKjXQ5QaeV
 f5L/+qFT891XI0IlKTgvKK7agBf+LCZc53ZdPC1KUaSjjnrb/TJf5hDRoTy/plH1eSz/
 STxw==
X-Gm-Message-State: AOJu0YzpjCYnI4ua2aIyhbA3U22euNRi7ivmcVhsFK5dqa2xcfvSwpI5
 dAJrPg+whenCQmCr9iXNdVGps0YzODod043tC1iyIxa26R5JpVJiSlb+Sk88JtB2dOmAfhfFvRd
 +cQRzFpc5Dg6TrTSPVJqeZ4RA4820dd20Fu7FJaKEev8+jZ804u8q0ZYoZqPiAF02VT4znF9Neg
 wltLuo3vBi9tPvrK+o9YA=
X-Gm-Gg: AeBDiet/FGeF25mzb4a7LyTdKrSJZ2YTio8tsB/hMg4RkSIKDKfPX1IaRn7FWV8RuKI
 O3uH2V6ocIneN7uJUnOzMfmQkNcNXELPnk7vWMvtBUXkJlVedouyP2bORlrnJofe/TLN+IiEsiQ
 E/0cIc8MQwoJxP8SOshBQTdWTFE1ma8zp+c6/qdCNtmuaNd/FB5b6WmjHJl0r07zgp4HReIAyxT
 vI43kmCAVvz59cHZGP60lS1o5zXkzW3Ga51DfDRSlHKxIINGwLGCso1MYgEAK50+eNCRtQMMBAJ
 pZPM
X-Received: by 2002:a2e:8a89:0:b0:38e:d870:1db4 with SMTP id
 38308e7fff4ca-38ed8701e72mr56180071fa.22.1776864239847; 
 Wed, 22 Apr 2026 06:23:59 -0700 (PDT)
X-Received: by 2002:a2e:8a89:0:b0:38e:d870:1db4 with SMTP id
 38308e7fff4ca-38ed8701e72mr56179921fa.22.1776864239263; Wed, 22 Apr 2026
 06:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260422103838.649578-2-rjarry@redhat.com>
In-Reply-To: <20260422103838.649578-2-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 22 Apr 2026 15:23:46 +0200
X-Gm-Features: AQROBzC4Wkgo9fYLKWKSaujpBdT5MdysgfGks15XP57xkEdcVXO2TWs6-_CZHWI
Message-ID: <CAJFAV8wa36zYGZmPp8idnERafcpSoSLaWnMps0oQovfabmLsXw@mail.gmail.com>
Subject: Re: [PATCH dpdk v2] net: fix L2 ptype assignment in VLAN loop
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Gregory Etelson <getelson@nvidia.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D7dufJ9-jW46oWFjKD6JpXiO8zETB9V1YyKnrKBFkzw_1776864240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 22 Apr 2026 at 12:39, Robin Jarry <rjarry@redhat.com> wrote:
> +static int
> +test_get_ptype(struct rte_mempool *pool, const char *pktdata, size_t len,
> +              uint32_t expected_l2, uint8_t expected_l2_len)
> +{
> +       struct rte_net_hdr_lens hdr_lens;
> +       struct rte_mbuf *m;
> +       uint32_t ptype;
> +       uint32_t l2;
> +       char *data;
> +
> +       m = rte_pktmbuf_alloc(pool);
> +       RTE_TEST_ASSERT_NOT_NULL(m, "cannot allocate mbuf");
> +
> +       data = rte_pktmbuf_append(m, len);
> +       if (data == NULL) {
> +               rte_pktmbuf_free(m);
> +               RTE_TEST_ASSERT_NOT_NULL(data, "cannot append data");
> +       }
> +
> +       memcpy(data, pktdata, len);
> +
> +       ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
> +       l2 = ptype & RTE_PTYPE_L2_MASK;
> +
> +       rte_pktmbuf_free(m);
> +
> +       RTE_TEST_ASSERT_EQUAL(l2, expected_l2,
> +               "unexpected L2 ptype: got 0x%x, expected 0x%x",
> +               l2, expected_l2);
> +       RTE_TEST_ASSERT_EQUAL(hdr_lens.l2_len, expected_l2_len,
> +               "unexpected l2_len: got %u, expected %u",
> +               hdr_lens.l2_len, expected_l2_len);

Since this test asks for RTE_PTYPE_ALL_MASK, let's validate the full
returned ptype, and the returned offsets.


> +
> +       return 0;


-- 
David Marchand

