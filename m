Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D8FC87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 15:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99031402AB;
	Fri,  8 Aug 2025 17:51:02 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 736A64028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 17:51:01 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-707365f4d47so23324436d6.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754668261;
 x=1755273061; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ASjS0kK+5V35btbJ4hV6MHk9cs5yfBnUx9l6T2JIyM=;
 b=kqMNdpmbP9ZeoBHm/2nFQ/10psctHyizbJZKRL3CU56p9xz/B9SRe0h2blEuIVxS/d
 rqjLxjZkHZUxKpNj+YaBvj4EGfM9nC/FJBgnakkWLUNGkeLRCMWzUA9ksAkqmQhU8Bpj
 LkWOTQy1eCWRBiXQc10SOXXIedK8NvxZQcGY1kKCkfPRpwL7wCCzBfbrPyNah4rXo2h+
 +NhSMaZXgr2JQqI+/6AXhPIyenBgRyv0rb3eKnJkJG/8TdpLVAd04WqsEHF3HHtRG9kk
 YaiV2vKGcDSyghAVbw5xomUOJ39+a7SGxhLmFiJgONm2IqC6PmgBsIGBT/T05Y4KT3Fh
 qvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754668261; x=1755273061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ASjS0kK+5V35btbJ4hV6MHk9cs5yfBnUx9l6T2JIyM=;
 b=WD9kz8jNN7iACU/GuW/0kK3MBDMsG5oVg104wDBc2Q020GnKX5vZHlwPveikU1BkFs
 K1IBrstabwkkbsGKKIssA5MsgdiG4giBo5lL7H1Z/0FYVG4t/LK1F8do0dxdN+E1M02Q
 nbFQg7mHhc6uMIG1mqd3pcYE93tzohkFFHw/sCjPFwVnSunak3mTwWuBJbDflNYzGab8
 V2PR0+odYMPmNAK4aFhnxJCvJUlluq3E0x/RZlw5puoCycTZ8ukMToCGpc6WnjHnnzZR
 H4nVQ2rJCDtE8gWhTrfhorERA68/5Tdm4cSsOQZ3CMArz+hD3d94J1waLY9Tbh7l+dML
 I9/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9nMr/2bhApR7w7cXqUtGtlGFHfglP3vQkisix9C2l1IscIsyOQRMFl7eFI9frK3VbGw=@dpdk.org
X-Gm-Message-State: AOJu0Yxdjv/DElJMr5qgvJ6WRNn+Nh8wEjAoupEN3Ou83jkqofiMgc2m
 JYRwFCHDqoD+LIFbbRoKrsjMW/VgTnxiEYwKDJjgwRZi9PelacEfv/pLeqpDalCcCQJkMhLitYd
 N9PZn+UomLfs9xscco4v42ZvPtFgNO9aN8LEDPFhmj+IToGoTIbJqTLe8oQ==
X-Gm-Gg: ASbGnct8OIl+pSo78xsKr/AAPb9WMwsBwXVUskVcaeDPlNDJLEx2B3wnXU1F9CIjga4
 si/Mc4aVUJ+ebHp0T08B0WNmbVfg4ah+u0A3dVGY5Vp7ojonRxzuUgKV78erm4NIdGD+iob7j6l
 HcqSVq/E6O8hbKan5DURgFWJSI8O6Ike8t3TCzlKrhykQGWeEZsvHs7RVMbQy3hvPO+mYBnxIv0
 wn1G6rP
X-Google-Smtp-Source: AGHT+IEMs8t3K8LJAo+hghs6zNxWcixnbfe7/K1sEj+p4OKtc5OyZS0zelvHjh+QFsPfKHXRISalR7Aftok2Xf7Tg64=
X-Received: by 2002:a05:6214:ca4:b0:704:d268:4978 with SMTP id
 6a1803df08f44-7099bac1fecmr48096946d6.15.1754668260720; Fri, 08 Aug 2025
 08:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB8596A4A5CCC22A6B1584AE14822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808054452.1350869-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250808082835.796b3be1@hermes.local>
In-Reply-To: <20250808082835.796b3be1@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Fri, 8 Aug 2025 20:50:49 +0500
X-Gm-Features: Ac12FXz8-kGekjmGk9HgXnrPVI5Z5d-m6Zj8vDqEl3Cb5GxyDcIMHuv-wS3meuI
Message-ID: <CA++2-x5yju6ZTz5uBcQFhLNrT2pkV9yOkuEjpD6awxFEc=rLqA@mail.gmail.com>
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Vipin.Varghese@amd.com, thomas@monjalon.net, Ferruh.Yigit@amd.com, 
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006123b0063bdc8a44"
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

--0000000000006123b0063bdc8a44
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,
Thanks for the feedback.
So, it means the patch is perfect in the current state (i.e., v7)?

Best Regards,
Khadem

--0000000000006123b0063bdc8a44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Stephen,=C2=A0</div><div>Thanks for the feedback.=
=C2=A0</div><div>So, it means the patch is perfect in the current state (i.=
e., v7)?=C2=A0</div><div><br></div><div>Best Regards,=C2=A0</div><div>Khade=
m</div><div><br></div><div><br></div></div>

--0000000000006123b0063bdc8a44--
