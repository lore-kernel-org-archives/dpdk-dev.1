Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D488ECA0EF8
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 10:34:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1260C402DD;
	Wed, 20 Aug 2025 12:34:38 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 695BE40292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 12:34:37 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7e872c3a0d5so610606585a.2
 for <dev@dpdk.org>; Wed, 20 Aug 2025 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755686077;
 x=1756290877; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D2+4W+m63NQM63pfxJUJJovISzuyRn4nBF+iHYVI3QM=;
 b=DxFsGQgUb5J2hBU15MTp7SsjXpPbKu6bdo1kJBKSohrp81LjColkLg620AjGcUr81v
 yOwon6kWqacPyf6PO8caAQd48sDQmw73m832h3F0dQHESBXBuXydCxumx4S0Vxsw/Et4
 JO1LOpn7lovJTzErHZNZGJhTE/RUawAxs5ngwmqU8ox7IN2rM47yPLC26XL5ughsA92i
 cTti+Hz6z1dO/Fw3GEIXmFQrzZJQlXVXdfKOnaOGzoYf/JMr9g0dhfkNXtNkRQTpU94z
 KlrdVg51ryZFEY4XzvmKwFn592sdBXIedpeLXy5SYuVtVZCEn0iAGqAEQMZgy6w/+srs
 2mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755686077; x=1756290877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2+4W+m63NQM63pfxJUJJovISzuyRn4nBF+iHYVI3QM=;
 b=ZdM2fsW5rY+hjRSqNqZdrDMYLBQkwqDYQptjK7nbar5bK/Hzyigf1dlgpZPO5n4MNW
 MtHd0S0ofxjg9ldJbdXHfgSIpym/6rj6QuDkbojdDoksaj6K4mR7CeR0H+033Xe6GIzv
 SCvGbYkmHT1Jw1atKNuiqpd3CDsJsVkQGVw5siz5P0h7g0RtzKITQKTGhbtuuhnj9fvh
 tXnvmbZHndI1JoP96ewUndckyYFXPw6yUcCA9Kpox/BX52uwNJl4egOpVDAx5KL2Hfxc
 EMfRTrEgvmwRgiRDWWncVKXBm6mIaaIevhsEmEsUxq1lHfwCEN/oY27zQD6nOY4Ed1O4
 Jnow==
X-Gm-Message-State: AOJu0YyxSLTK210nRKBxT9aqpsMqfa9uR4ieFd6b0OUyoZtnNzMdHh9C
 huQ1WVwdj8oAdoegr5f1y80Vbuz2NAmfVoeteql0l4axE9GT9OSHquhwXtvUMMlaCTOzrmAmOeH
 5J+Laff+GHNOXh/SMcvcPjn6DpcHuB6I3KOK+jyvJYQ==
X-Gm-Gg: ASbGnct+QNI8mnrkH8xFX0HKwn3PbB24LkkiP7vt51NTmvOZBaGdwGUbFtY8NFhTbjy
 Slj7ltck6BX3POODHPpfPmZjYY0NIf40ffmwcvXrTqgtbBlkEVltJSZYTGr8yanqEdB8Y1OxPVQ
 7H5sowmmNilXTga6FPvktVA1XmC4LA7VK1heCEPLAVrHmkxZrzhHDF10ft8bTsCdVtAESzbQXy5
 6cw
X-Google-Smtp-Source: AGHT+IF8jvSMmdSOIwN3x31628FH0YQTD2DvZmXghrY7HZ4z+IyTk4t7SJm2iB7Qq+7kNNykzmEBflHKTogDf8kDj2E=
X-Received: by 2002:a05:620a:2687:b0:7e8:6cf0:2c98 with SMTP id
 af79cd13be357-7e9fcb0bcc3mr267537285a.41.1755686076658; Wed, 20 Aug 2025
 03:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
In-Reply-To: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 20 Aug 2025 15:34:25 +0500
X-Gm-Features: Ac12FXxBsGTA118U6xnJJp3pBbo15_eo-c4CdJLMiIrTtkqf8vbgITqDD9kt694
Message-ID: <CA++2-x5UsQbdu3=ixYjP+XhESwORzQq-VpWu2J=z6SjXkS1U+g@mail.gmail.com>
Subject: Re: Segmentation fault when running MPRQ on testpmd
To: Joni <canary.overflow@gmail.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000efcc20063cc984d6"
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

--000000000000efcc20063cc984d6
Content-Type: text/plain; charset="UTF-8"

Hi,
I have run your command with minor modification on dpdk 22.11, it is also
running without any seg fault; please try below one:

./build/app/dpdk-testpmd -l 1-5 -n 4 -a
0000:03:00.0,rxq_pkt_pad_en=1,rxqs_min_mprq=1,mprq_en=1,mprq_log_stride_num=6,mprq_log_stride_size=9,mprq_max_memcpy_len=64,rx_vec_en=1
-- -i --rxd=8192 --max-pkt-len=1700 --rxq=1 --total-num-mbufs=16384
--mbuf-size=3000

Regards,
Khadem

--000000000000efcc20063cc984d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div dir=3D"ltr">Hi,=C2=A0<br>I have run your co=
mmand with minor modification on dpdk 22.11, it is also running without any=
 seg fault; please try below one: <br><br>./build/app/dpdk-testpmd -l 1-5 -=
n 4 -a 0000:03:00.0,rxq_pkt_pad_en=3D1,rxqs_min_mprq=3D1,mprq_en=3D1,mprq_l=
og_stride_num=3D6,mprq_log_stride_size=3D9,mprq_max_memcpy_len=3D64,rx_vec_=
en=3D1 -- -i --rxd=3D8192 --max-pkt-len=3D1700 --rxq=3D1 --total-num-mbufs=
=3D16384 --mbuf-size=3D3000</div><br></div>Regards,=C2=A0<br></div>Khadem</=
div>

--000000000000efcc20063cc984d6--
