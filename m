Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FACD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 18:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDF24402B6;
	Thu, 18 Jun 2026 20:51:27 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 32C184028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 20:51:26 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30beab3af9eso3472102eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781808685;
 x=1782413485; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5UdWRZfOBigf424H6lBsGkdIpw19MGd5kdQZGOOnk8=;
 b=iqHs5xoiznJwir0tAbKN8v8u7AW2G2o9aJCmrdIDThzL1t+nmL6dDD4eWo7rjgmf93
 qoC02t0Z6LnrtVhWKrYJkmlYZNrNBKG9N221EEi/ihRQotTdXQ8oHA61vYHRb0miDlcu
 a/X3JkewHf3FI7vxSGtG7oeuKoyiYmvP0pk6td4OgqFjiwotojGplX4yN+ZLdGM+o57l
 vYTyJeGetgirMfsTLewKu1QrUo40nxu8NfMfwmRKgjvCCtJ7WWfpfLd5nLPUsHfRkpba
 /UFmLctT0XWXDm8LSwobGNFJ1YPHpJQQvMd0UOj6u8C6b+2HKr25Vu2k/TyoWSd3+Igr
 5I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781808685; x=1782413485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5UdWRZfOBigf424H6lBsGkdIpw19MGd5kdQZGOOnk8=;
 b=kkg+y/6BMrHLyusagX8Xg/xNoV4e/rT5btWoMqW7+7AZ3Q9UnzjM4OhfHCGwc/lIo8
 9Zik1rEys/qjku8BT2ppuTlcn2sId+hyZh112GeN+2WJILz/1e6MMZb/YZnwvLwU8Baz
 fe8HeHauvhh57n4irt7f9nZYlmbnhdUdGAdjt9aF7PV9ArD1bXwlUPgNXNLhpsEgSJmW
 cC9as4x1Y417OEE+Jn+B1cxzm06GRToZnD0cZtTVqxKkFBLo+cdBkLk0g01j7K10YQDn
 6wKL9mb2/+vn4N3XJrUh3q05kVF8m/0XC4wd/EI0Hrxhk4HjaBVfbIioA5wlaQIn4OK7
 wUpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hB1BC6Rzl+qRTrawUIbEL9GnWeaERkLiDidVPKF5BCDIrPufuqe4lx0QFW9k/dXnGk3I=@dpdk.org
X-Gm-Message-State: AOJu0YxkhYJ6pLEnqHvyHXQRdZspCZ1dIPDAhf9Yp+1+gr94oCdVzLgP
 vTZ6IpwiZajIRcWcm/HP4UDP9mFW8w2jJhMmXC9rPrvjbxMvVa3vUZ/LtfJUCDA4pfA=
X-Gm-Gg: AfdE7cn6z/dAe4qC78SprhVJQAqRtjPn5FKM+Y85y+1kaEoryLQmF3oQLWMPR+0hhgF
 /adkVrCnOhLzaHrlU4APnxUzT5La0oE0GqdLsxAa+rHriyAOlpp5F47q/PN9REJmvcvhP477q0q
 DOiEq+R5qPVn0cTmT9GnWBJPv+LGmOaH2LSF/T0BLSGKYBHIrd8INJgzNVDQdZi2V74dF89Mx33
 18W3j69nu4ZOPhJRz5/WibksBmhEWNQLE0OtV6kO64HctxC2xcPUeWjQelnBCJwIwloDxThqB8K
 DDAbfBvoJSFyrReVpRYE7fidhWMYBT6KAJA3PYBVA3RtG1kWg3wXm2Qr/Aj5GcWifDHMqqioS3B
 xYuWHdwaqTmNybsxn0c5NCwpg8J4qrFMxAEcUA3l7lyPQtQENz8ADrjLFUFCcucxr1o8iA/4Yej
 KGtBxnl+4P9hYU7xqi6JdSoZtRVoltkJqNvIdHb+plS4SKYW6d+d2vpSBCspmBtsg+
X-Received: by 2002:a05:7300:8c95:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-30c06e03f03mr426451eec.2.1781808684967; 
 Thu, 18 Jun 2026 11:51:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d5e302sm260251eec.28.2026.06.18.11.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 11:51:24 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:51:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Dawid Wesierski" <dawid.wesierski@intel.com>, <dev@dpdk.org>,
 <thomas@monjalon.net>, "Marek Kasiewicz" <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 1/1] pcapng: add user-supplied timestamp support
Message-ID: <20260618115121.4b4766f4@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65924@smartserver.smartshare.dk>
References: <20260618143819.310046-1-dawid.wesierski@intel.com>
 <20260618082240.517e60cb@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65924@smartserver.smartshare.dk>
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

On Thu, 18 Jun 2026 18:45:19 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 18 June 2026 17.23
> >=20
> > On Thu, 18 Jun 2026 10:38:15 -0400
> > Dawid Wesierski <dawid.wesierski@intel.com> wrote:
> >  =20
> > > + * @param ts
> > > + *   Packet timestamp in nanoseconds since the Unix epoch. If zero, =
=20
> > the =20
> > > + *   current TSC is captured and converted to epoch ns by
> > > + *   rte_pcapng_write_packets() when the packet is written.
> > >   * =20
> >=20
> > It might help users if a helper rte_tsc_to_epoch() was exposed. =20
>=20
> +1
>=20
> Please note that such a helper would need to compensate for rte_rdtsc() d=
rift.
>=20
> Simplified:
>=20
> int64_t rte_tsc_to_ns(tsc)
> {
>   struct timespec ts =3D clock_gettime(CLOCK_REALTIME);
>   int64_t now_ns =3D ts.tv_sec * NS_PER_S + ts.tv_nsec;
>   int64_t now_tsc =3D rte_rdtsc();
>   int64_t diff_tsc =3D tsc - tsc_now;
>   return now_ns + diff_tsc * NS_PER_S / rte_get_tsc_hz();
> }
>=20
> A performance optimized version would take "now_ns" and "now_tsc" as para=
meters.
> And with "now_ns" passed as a parameter, the function also works with oth=
er clocks, such as CLOCK_MONOTONIC.
>=20
> Also see this discussion on the Grout mailing list:
> https://inbox.dpdk.org/grout/98CBD80474FA8B44BF855DF32C47DC35F6590E@smart=
server.smartshare.dk/T/#m465a04ca2e8219612dd9c3efb4198d23d5813422
>=20
>=20

Inside rte_pcapng is already all the necessary state and setup.
Just not exposed to user. It does it without divide operation
