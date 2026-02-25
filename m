Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C74DFD377D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 18:32:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F7054027F;
	Wed, 25 Feb 2026 19:32:56 +0100 (CET)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 80BAA400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 19:32:55 +0100 (CET)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124afd03fd1so10114491c88.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 10:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772044374;
 x=1772649174; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R00320CiJGfJEYaOK31j18SJCMwz01mJ2nazA7XUum8=;
 b=ALTBOGxiyfKAxLZaegT6iWlifGinl5PaWF0qVeIPvmQl45xoFJTwZjQ0JzBKpWoXJQ
 rriCDqWciWUEXbD18VlXYSxwBNbEbxakYT+Gj75WLEAN/gYDLP9U4c+DlNXYuEK2ri6A
 ZQtFH+7xr1/hMD77SV5arGlkfptkYApMIrGEHQDj6W3t2MJezSqhF0CizRlI62xCvBgq
 yOJK2zFGaMePm6m7rKdMikdc+kIMMSc6MD32eAuETQj8+3JZG1v8fx89M3XWj1ljPvd/
 iGDTsDmoUtYpCkmd7JsnF/ELDpIH/FNGyCwOTlB1c1o+AFKHrfdNPX18TAgIvYJ9abPL
 Rdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772044374; x=1772649174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R00320CiJGfJEYaOK31j18SJCMwz01mJ2nazA7XUum8=;
 b=dJRz9f/8EQ1K48SufHoJN1sPvDNXiyYXHqZ4f1KNRWY7jsVPue9LFryY2lkOpa8a+J
 QSU2zEOx+2TpS8u7JfI0S4pjVlcTRJ4aaZnRmyi7H/dDDPCs1Glaigq6v9PNgJX3CZfK
 DWjTvkPOl60zOuv1t9R72M+AyJl0EzPmRJ1J34uPwnLZI/JwVx8KaJs4CDybWl4Q3QfF
 QdQ3eUSP9XmVqzN3WeyX90coR8mrIsvTt4fK/xngb9I2OmWFxmW+9U6W6s3MThYPJzC8
 I2Lv6IAHWXcDba1a/nMi6C99DqWkKXYOepd9gC53wE6AQlDGD+eJP9/JKFu7peyRhs55
 fUqA==
X-Gm-Message-State: AOJu0YzVfSLMDADpmIHLJz5Mi31e+uw3S+lvTgnx09zhQqrU1g1Dokh3
 4PL5OQtVSiUr1jYWS0nAdexOawlme6gQvZ79agIx3gHodP4v93tdtJqYf4HAc8L5JJs=
X-Gm-Gg: ATEYQzyooZRU2OgGEIEdnfBZ8aLSbPh4NeHi9FARaq/OYye0+Z54cZUgDD4u9EwvCPP
 q27kyRB6zyOhSCHv18pyONyA+z1W6HhVKvT6mvR81GhI1HggqblOCCGkHg25lr3sQnN/EFTN5Pd
 XX6FGbEcfxNj/b827SKv+xI9swJi4FBq36syaLtNHjHqXrYo4DM+iu8TU1Hy+mlySzQNwQ0JIBM
 FjRcdst3K11BROmfcya38z4Tc4aW03+w905MQ81riD0aR0CApFc6YBjSRZgK5sLYiqBg4ZKa4zD
 9Ys3rn1iUKp2ZeWsz6DauiEdalft1FgEneGJ5jOoKAezETjCc5DMwckbUAorbT9kpgSdyHVMWLr
 bmx8sH49Ghp4ssL60f+lOw9yafkda/m43/lNAu/MLoPBygFhdGaDG7ckyS46Tr27iPiVAsV4HxG
 NqzjwJFm/nZQOmuxdA2wWPlXMav910AMY7L8+s4YP55h2ckKbxCbe0bpzU1vL9rmjK
X-Received: by 2002:a05:7022:1284:b0:123:35a4:e8be with SMTP id
 a92af1059eb24-1278695884cmr415623c88.13.1772044374404; 
 Wed, 25 Feb 2026 10:32:54 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af9f74bsm12228618c88.15.2026.02.25.10.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 10:32:54 -0800 (PST)
Date: Wed, 25 Feb 2026 10:32:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, David Hunt
 <david.hunt@intel.com>, Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] examples/vm_power: fix format-truncation warning
Message-ID: <20260225103251.37c715f4@phoenix.local>
In-Reply-To: <20260225173632.283928-1-ktraynor@redhat.com>
References: <20260225173632.283928-1-ktraynor@redhat.com>
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

On Wed, 25 Feb 2026 17:36:32 +0000
Kevin Traynor <ktraynor@redhat.com> wrote:

> Without libbsd-devel strlcpy is defined as rte_strlcpy and a warning is
> raised for format-truncation. Observed with gcc 15.2.1.
>=20
> In function =E2=80=98rte_strlcpy=E2=80=99,
>     inlined from =E2=80=98add_host_channels=E2=80=99 at
> ../examples/vm_power_manager/channel_manager.c:600:3:
> ../lib/eal/include/rte_string_fns.h:63:24:
> warning: =E2=80=98%s=E2=80=99 directive output may be truncated writing u=
p to
> 4095 bytes into a region of size 108 [-Wformat-truncation=3D]
> 63 |         return (size_t)snprintf(dst, size, "%s", src);
>    |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Check for truncation of socket_path[4096] into channel_path[108] to
> remove warning.
>=20
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

Since socket_path is a unix domain socket path.
It should be UNIX_PATH_MAX (108) not PATH_MAX (4096)

