Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9A6C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:18:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4874742D96;
	Wed, 21 May 2025 16:18:53 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 5A0054028F
 for <dev@dpdk.org>; Wed, 21 May 2025 16:18:51 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-6f8d4375aa5so25457986d6.0
 for <dev@dpdk.org>; Wed, 21 May 2025 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747837130;
 x=1748441930; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3koOaxDM96mbi/uMvQwMEg7MzFlLm/DLPScApk7rlk=;
 b=SpMgp8B2//1BHN/NKZzx7vlu9NHk72ZNPw6Y/YlR4uTSMHHd2eSNSVEP26WLYBRIME
 ndNuUS1+jraM2cR1FAmdXwsKFCCB0iYYrJxjMKfafrQrQjaSiMZuzp+I22AJka95vjyi
 L6RUqoJHpvymLcOyQdlnKE9t7qLha3mjOVb+8dmWTsxwv+zWDVvWnaJTy5jPz8srkrYZ
 hHoXmoUHod+vupjYjc3cRNUCEOf9AH/DRGHypVmY8LdUyRVP0MLoX4YDjyhd9yTlRV+s
 IKqkFHhRza3uzhUIGqATWvuVSfg8SvUkGbVByi1XYV7dCppGlGuki4VX9kWzyF05JkK2
 sGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747837130; x=1748441930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3koOaxDM96mbi/uMvQwMEg7MzFlLm/DLPScApk7rlk=;
 b=n8FJ0H9Xgt6lU+XzBq07me8mYhudfTIr0EhMd3n6MnHs1lFemNCWx+I0IAa23EUb61
 AXwDaYNBX6aUquLdM3ywWVelhbPpPGiy1Y8yUIl/Owr+tjs6BHM/GUYSEbM8Dsk/1VOR
 kGfet7lK5b3bXxD0NYSmNBuD8UrKfBmSDrP7rNWHxelZqlhpYSgchG1voqOPG0uXnkAJ
 IvSFmZUv9nIq+qbKzl1LQrvpNnyU9+C54Dzzg6oGRXfAQw+Efas7wEyjBPYI3jyM1fuR
 dJNTaTFVhtrCG4a2CrClLEAQVGhqGv4j5aREveHThHKV3AXbBEa4mdEEVOIns9aap1uF
 Ofjg==
X-Gm-Message-State: AOJu0YwDMoHq5UIbP7nbw1llx8B9+UjnYUJNTNsFh/Xv91eZQCN+jHgP
 LkSpW+9x4MB47ASB4BB68Pt0ly1+2tkI+YAyWe4Ps5AflKxTGFmuNAhEDn/xt+6q4vE=
X-Gm-Gg: ASbGncvKTZLFyLo2AkdxJpLSqNgUSs+3zj4yHLxjsEzbxlYWPs7vPH4Mbb+rvqW1y6e
 5xtxsoq5JR6qw1Kj7p+7mZkGxjf9lGLkzOdtkOFM9kT7sVIATg4G4fqt1nqAru5IeHxRIOZK5uF
 dnPX9Uk1S/akCdesqwH+MfpvGJQvqQkrIeGNUb8SxO2r3PBOIQfPm39OHFIgNvfM9taM63kbLin
 WbBckX1lJvUi5O5kVIUc1LkagUNLlfM9qOHWMVmNfnWeIlKmf7NFwAcaQQ/kOlPZ/wgeqD2j4Yi
 vmOt3RAL/W725acjnPssfzPUgoV1V62ye98lRFWvUuJW48Yv4P1KtIF8/bpVpW4UI2BJypHu0Yj
 G4ecEy9IAhSi1ML+ye3Wp4vS4zg2L
X-Google-Smtp-Source: AGHT+IHC5llvpNEIYuMqfqzCcbvHp/gvkN7vEUPcIq5QfLN/Xwp67IPmHlotcdq6+lU+Z+ExxpEsfA==
X-Received: by 2002:a05:6214:d6f:b0:6e8:ff46:b33e with SMTP id
 6a1803df08f44-6f8b094a1b0mr364985936d6.37.1747837129991; 
 Wed, 21 May 2025 07:18:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b0965b7asm85555146d6.80.2025.05.21.07.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 07:18:49 -0700 (PDT)
Date: Wed, 21 May 2025 07:18:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: farooq basha <farooq.juturu@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [dpdk-dev] Regarding HQOS with run-to-completion Model
Message-ID: <20250521071845.50d6f9e1@hermes.local>
In-Reply-To: <CA+xuiv2jL934JR_QyLC1M5A+5dGPzw5L0=4RoS98eRjueA+9-g@mail.gmail.com>
References: <CA+xuiv2jL934JR_QyLC1M5A+5dGPzw5L0=4RoS98eRjueA+9-g@mail.gmail.com>
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

On Mon, 28 Apr 2025 16:55:07 +0530
farooq basha <farooq.juturu@gmail.com> wrote:

> Hello DevTeam,
>=20
>     I am planning to use DPDK HQOS for Traffic shaping with a
> run-to-completion Model. While I was reading the dpdk-qos document, I came
> across the following statement.
>=20
> "*Running enqueue and dequeue operations for the same output port from
> different cores is likely to cause significant impact on scheduler=E2=80=
=99s
> performance and it is therefore not recommended"*
>=20
>  Let's take an  example, Port1  & Port2 have 4 Rx queues and each Queue
> mapped to a different CPU. Traffic coming on port1  gets forwarded to por=
t2
> . With the above limitation application needs to take a lock before doing
> rte_sched_port_enqueue & dequeue operation. Performance is limited to only
> 1 CPU even though Traffic is coming on 4 Different CPUs.
>=20
> Correct me if my understanding is Wrong?
>=20
> Thanks
> Basha

The HQOS code is not thread safe so yes you need a lock.
The traffic scheduling (QOS) needs to be at last stage of the pipeline just
before mbufs are passed to the device.

The issue is that QOS is single threaded, so lock is required.=20

The statement is misleading, the real overhead is the lock; the secondary
overhead is the cache miss that will happen if processing on different core=
s.
But if you are doing that you are going to cut performance a lot from cache
misses.
