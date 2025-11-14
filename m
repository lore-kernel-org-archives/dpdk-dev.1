Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB8CE8D55
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E096040ECF;
	Fri, 14 Nov 2025 18:08:04 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 85EF140E26
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:08:03 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7b9a98b751eso1465979b3a.1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763140082;
 x=1763744882; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IkMRdOVywHSmh8TdSQ6l575QcwjFv8eY82OM95vn6wk=;
 b=WkJ+mWqTIgH6OsrQh0q9TRZqJRj/+jq1PfUysQgteQKWre8pr467HnP/AmnUk0RhQx
 388YIbIHZF603Rakmimu9MdTB8dcMSxirvsrgusMLw+k69KbrBY4UiFjDKb2/ihKYgMT
 Qi4UZKbEZWszyiA2+zgx16FLbrrAcwGxEejt4n85atiElWd0x/qYHs4kKaAbiYuiKKwd
 4Qye3v490SVpwlRMyZNanI6SiT43f7VAdt7S9vaP4OPcX0ushfb9Lm3BQd9e6KFxEsXj
 EF2LIXs4fusxFbXmWzYo1c3kIOWLwS0fMeNjTscjGo/8UvwPOXvhMZr7HtajC+w71lcr
 OJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763140082; x=1763744882;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkMRdOVywHSmh8TdSQ6l575QcwjFv8eY82OM95vn6wk=;
 b=nr3wPrPDc3/tq0y75OCLvaN7Wd2Ypk3wHxg6Tq2ETS5R6t0GAcpSuvI482Mq7F+YW/
 iMH0XYlp2JWzzC7QLQr3AFKC0C5qwd3dZk/2n1KgZ2PfWvXcR4axDagfRSt5sgxWh7hY
 QgFQLSmEDQ8rBksTyZv8ViYv8yHc/cZ6H0mFDKjagxbU8lGbMp4NaBxDVyzyYEXMAB68
 MYCUlRIn9hPCDKL5J9MJvU8ecirz4zjjtvn+YSYuw3EXZxNFsvCNUGnk1hieB6hqBiZV
 PLHNjDato1mc1afQlywFhD7KR9wDs1+fqDCp/tY6T0AifpiAeIXRNCZkThyfgTd3GN/X
 TolQ==
X-Gm-Message-State: AOJu0YxCL1xyak2avR5QM42oLM+8SrE8RV8EBH/RvAuIlh8+5a+HfQRS
 iwqu0CKnmYgxBdLKIRnZnW/nqduou5pZsmt/bsruVA66/b5EbNsh9TlDyDN90MKS6Yg=
X-Gm-Gg: ASbGnctwDvqnSd2TiyQsuCX+CCHFJbH4bCoeNTKqJSmZvtl7CYSL+580AWJDlBNvoB7
 dzL0J8Tbqp5onfQXrJJxKzqFAubS1J+q9SO4dBIp9cLyrgW9wrPd0ix47GO4jxZ590Kr9dWjsGX
 pr+ok46zb6JOxGQiAwv2RU1lrFtYh/ljmMj9v47zAqb4/MxYFSiaxE62xvxniAF/1nmNEfSWCSc
 MDlyPufJsFvu15tY2sNnadiMTZC/m+IShXJRb4GJncAcKwB2+wbNysekyi4GSvyXdM7Yke8LJZd
 pwOAPuQdlGhT37kZ3XF6C9OhG5CKPdk29WCziUATaCqGCUwegFUhlgl3aKW+Sci8SKTXWxHuviZ
 rgzN77LFxXU1eFuMPy+wY33hH52N91eLq28+8mDyssb85mUlffkjCOZ/z8rGINiHAxUJ80cdm3e
 FcwcpcZkeLEJ1FUv9Z5XNYvOt/G/KXbPQvRObsBrOYCaD/
X-Google-Smtp-Source: AGHT+IFhgFZc4yYc9aQDrtT8bSThU3plAPK8JAbBvVxrEvKXPrR7jvBID51UA3Ye27rw33Gewx9W7Q==
X-Received: by 2002:a05:7022:b902:b0:119:e55a:9bfa with SMTP id
 a92af1059eb24-11b411eda31mr831878c88.22.1763140082494; 
 Fri, 14 Nov 2025 09:08:02 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885e3sm12207258c88.0.2025.11.14.09.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:08:02 -0800 (PST)
Date: Fri, 14 Nov 2025 09:07:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: warnings in e1000 with gcc-16
Message-ID: <20251114090759.14792716@phoenix>
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

Building with latest gcc-16 and DPDK shows these new warnings.
With current annotations on rte_malloc, compiler is now tracking sizes.

../drivers/net/intel/e1000/igb_ethdev.c: In function =E2=80=98eth_igb_add_d=
el_flex_filter=E2=80=99:
../drivers/net/intel/e1000/igb_ethdev.c:4280:50: warning: writing 64 bytes =
into a region of size 24 [-Wstringop-overflow=3D]
 4280 |                 flex_filter->filter_info.mask[i] =3D mask;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../drivers/net/intel/e1000/igb_ethdev.c:4265:23: note: at offset 152 into d=
estination object of size 176 allocated by =E2=80=98rte_zmalloc=E2=80=99
 4265 |         flex_filter =3D rte_zmalloc("e1000_flex_filter",
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4266 |                         sizeof(struct e1000_flex_filter), 0);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/intel/e1000/igb_ethdev.c:4280:50: warning: writing 64 bytes =
into a region of size 0 [-Wstringop-overflow=3D]
 4280 |                 flex_filter->filter_info.mask[i] =3D mask;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../drivers/net/intel/e1000/igb_ethdev.c:4265:23: note: at offset 216 into d=
estination object of size 176 allocated by =E2=80=98rte_zmalloc=E2=80=99
 4265 |         flex_filter =3D rte_zmalloc("e1000_flex_filter",
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4266 |                         sizeof(struct e1000_flex_filter), 0);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/intel/e1000/igb_ethdev.c:4280:50: warning: writing 64 bytes =
into a region of size 0 [-Wstringop-overflow=3D]
 4280 |                 flex_filter->filter_info.mask[i] =3D mask;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
../drivers/net/intel/e1000/igb_ethdev.c:4265:23: note: at offset 280 into d=
estination object of size 176 allocated by =E2=80=98rte_zmalloc=E2=80=99
 4265 |         flex_filter =3D rte_zmalloc("e1000_flex_filter",
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4266 |                         sizeof(struct e1000_flex_filter), 0);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
