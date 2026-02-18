Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAC0E9A041
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 02:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F53940299;
	Wed, 18 Feb 2026 03:34:38 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 087524014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 03:34:36 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so244884f8f.1
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771382076;
 x=1771986876; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ocwEeBs1526lBFhAURyxUowtLanoLtis+HCdgW3Uos=;
 b=m2TvjyCtC/JNLSRZNUEx9A9B3lCuEAJElu0DI0oGXFdMoiBLeDlfUmZXxYq7nnyxOb
 BGSDR6h3wAvqMqLf+309qaFGPcrJXQrOADQpvrYUkAYigtWTe/tpyaEXmDY0n8dZ1Kmd
 BReu0wqcAURZx9CUvqRFsCXr+a2hTEwOMzkG3a90F8MVU7mxvoxofM6UnAjf40mJu4+F
 jERbLUbcnPv7TIEUmVpGhsdeUZsM8xxy7rJYQm4CxOdRCJGS3d6/4ia8y9/4iDafWNpY
 VSuXTQOuRx3mP/uZdIvaONeI883HsxLnMEt2INz80Fl6x+ZqGgNRgiodbVcDzoLyjRhJ
 XMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771382076; x=1771986876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ocwEeBs1526lBFhAURyxUowtLanoLtis+HCdgW3Uos=;
 b=XVgcexMAOyfa3pNDRnF+14ThIaBNdfw4mIv/GU/VroGcAPvmsALIjgb0bAC9jmn9b0
 YTa9FgHg5/5qk9PhtS4N2WwpU0uZf3C6HG1JKrI0kK6BbT5ELcDzmKWhPJKxN/t0Xbgn
 xMjO6C2vPw/+h1qZRwUvw1rr8mDPoORI+g+jWRG3T/EgurPCbhYc2yCxAX/v8AN4D7vw
 5mxgTdxwKQVbm2ETDyTNq/Afy1H2jTPkAyRRzzDrq+cKobr3E7H5SBja6uTcWJlOav7Q
 UqbduemZ2nzPsLoDx7dk3FC9yYsr/pLCWynRhAWTG6CAGxjni1S9mlkQJTMBwugBK4eX
 2AOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcZvPEbT79cHO2mRCBh98IvCHryGIBAeUaibnfRGSIaFwGtqlk+iOSIzkse0Q/IROlhfo=@dpdk.org
X-Gm-Message-State: AOJu0YwqcD1qso5APLqj750JU6FDYQV2L9a7Ig/B9vu153vKBayPhTQX
 Z9DfKp67dtqY/tUI1y0zG+7FJXfMImYA4FEmnp/mTgY6dtQqCKA/5iLu1L6QUrPPdeI=
X-Gm-Gg: AZuq6aIovjXpUzm5LwSoUUMC4yn+uoqKdAwi//ZHFdpfGYVqH7RmNxU4bwE9M/Nb2a5
 uLvZ1lJ1hKOy3M9eykvygHnO6/Z2v2mQ1zyfRQgbI0sAF153/Ks99MTv8BKPkzSFilk4ID+siQJ
 KNOcKj6nIbK/I1ACdU6vtgCczAqxayke99NPzOEbpGEEL84eqCghQv8o4+ce1xL5MWkGLJ+9eia
 sieRae9tsw+R9/iB6IfUYas3xB/29oPjF9+hJwZjYzWwBigrQhj9fENcgTaoZYNju0cwrrsaIOf
 LGWOqrkC4YNjX6JexHZFJVDqTyE5akezPgXi5n6ldiAZuvvWuy9AA7Bt8kbNCEFgv38GLZCavsG
 3ZUITPQdJXS/MhbjZYF9jt9yYzG3cIBTQFeMI1GvoPG50u0Z3LOKfoJspnmzL0BqeEXnprYEEBN
 KyUCsmLLKRMyothQVeDjHsBTp5nVeSuCvy4E/556H0P27QWhdIGb6M5zdnOJyCPk1Q
X-Received: by 2002:a05:6000:1866:b0:437:7719:ca82 with SMTP id
 ffacd0b85a97d-43958bfbed0mr794217f8f.3.1771382076433; 
 Tue, 17 Feb 2026 18:34:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5d156sm41829382f8f.5.2026.02.17.18.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 18:34:35 -0800 (PST)
Date: Tue, 17 Feb 2026 18:34:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pekka Riikonen <priikone@iki.fi>
Cc: anatoly.burakov@intel.com, Dev <dev@dpdk.org>
Subject: Re: [PATCH v2] bus/pci: fix automatic interrupt type selection
Message-ID: <20260217183429.738020e8@phoenix.local>
In-Reply-To: <d612fb276b9c8b173a5e476ca75b0460@iki.fi>
References: <d612fb276b9c8b173a5e476ca75b0460@iki.fi>
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

On Fri, 20 Jun 2025 15:50:27 +0300
Pekka Riikonen <priikone@iki.fi> wrote:

> Check if kernel returns 0 interrupt vectors and try another interrupt
> type in that case.  Failing to check the vector count can select an
> interrupt type that's unusable.
>=20
> Signed-off-by: Pekka Riikonen <priikone@iki.fi>

Patch looks good, automated review had some feedback.

1. Should add a Fixes: and Cc: stable@dpdk.org

2. There is a pre-existing bugs in the file as well

Error 1: Missing handling when interrupt type was explicitly requested and =
count is 0

Confidence: ~85%

The existing VFIO_IRQ_INFO_EVENTFD check (lines 223=E2=80=93228) has two br=
anches: if the user explicitly requested this interrupt type (intr_mode !=
=3D RTE_INTR_MODE_NONE), it returns an error; otherwise it continues to the=
 next type. The new irq.count =3D=3D 0 check does not mirror this pattern =
=E2=80=94 it unconditionally does continue.

This means if a user explicitly requested e.g. MSI-X via command line (--vf=
io-intr=3Dmsix) but the device reports 0 vectors for MSI-X, the code will s=
ilently fall through and try MSI or INTx instead of reporting an error. Thi=
s is inconsistent with the existing behavior for the eventfd flag check, an=
d arguably a bug: the user asked for a specific interrupt type that doesn't=
 work, and should be told.

Suggested fix:
c

		/* If no vectors, try another type (or fail if explicitly requested) */
		if (irq.count =3D=3D 0) {
			if (intr_mode !=3D RTE_INTR_MODE_NONE) {
				PCI_LOG(ERR, "Interrupt vector has no entries!");
				return -1;
			}
			continue;
		}

Error 2: Resource leak =E2=80=94 eventfd fd leaked on later error paths (pr=
e-existing)

Confidence: ~90%

This is a pre-existing issue, not introduced by this patch, but worth notin=
g since the patch touches this function. At line 240, eventfd() creates a f=
ile descriptor. If rte_intr_fd_set() at line 247 fails, the function return=
s -1 without closing fd. This is a file descriptor leak on that error path.

Similarly, the rte_intr_event_list_update failure path at line 236=E2=80=93=
237 is fine (no fd allocated yet), but the rte_intr_fd_set failure is a rea=
l leak.

This is pre-existing and not caused by this patch, so it's informational ra=
ther than something blocking this patch.

