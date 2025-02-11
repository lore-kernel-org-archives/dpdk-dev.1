Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B57C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 18:18:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 739AC409FA;
	Tue, 11 Feb 2025 19:18:46 +0100 (CET)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mails.dpdk.org (Postfix) with ESMTP id F2C9F4067A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 19:18:44 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-30761be8fa7so53699421fa.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739297924; x=1739902724; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgnsIjNIBShhSjthNaCVjBpS5vqWJPftEkRgdrL5BZU=;
 b=ADJ9ZIBA9Iwj6Xr1kj3gdiaIh0r3FigRUej0DoWLLT3aUfHF1sM3DcUFRAhCZ6TC2k
 FAvs0IdlvfUXQNp/682J9MBgbmFGKzanczAgiZW0Wr+J+Thmqkb8nND8SEUOpziD2WJ4
 g8hE3r7t/q8y+wvH/7nnIawckcMSgK2VLZ41U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739297924; x=1739902724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgnsIjNIBShhSjthNaCVjBpS5vqWJPftEkRgdrL5BZU=;
 b=Ok9PzRzko6FoUTjTySbG0gJZTIvbgUqvwxC83Ih1aefWswqIas/JH82XL1RCmKQjAR
 MCN5uatW3CyIFcVtIS9Hs/6pKOj0zUyZkrmRPa7qKNUzXkOr5juBHXuLULDWCpQmArEX
 y9jOB35wCJY9teFqe2mSQSj2Y58PM+AC2ormXYt8nBbQHIymEufWMryrW6wis4E/yEyq
 6h9uAWzKxNTuBJdqP0XxP2bVG3+dWh/pvItY+0R2+ButKCcO7piiEhSOThxU/Cw/FTUd
 nomo1THN2PPTx6JmLZzpAKzrLrMnFdk1xz+M9IsvQb4g1curDAqhQDBjbCzZs9b2Rtc+
 RQJQ==
X-Gm-Message-State: AOJu0YxU2ZojDF5A7UNYbpFcz/w7poqur6Z/E+16zg2R3nhknp1pkCzZ
 esVdoJz630Nltqnu0l2fYLdCzcOGUXJhAYlwVkpIfXz0BPXg4VGB9XrYifGhazrdYsloLEBNwU4
 SEsWhGfU+qCWFKJA//Za+tByutrExHHStLn3HEw==
X-Gm-Gg: ASbGncvoAP34z4QcwEuXURXV60i73O1gGkKw2iWkrcK80XolsOctYy2qek1zehL3by0
 kRDTU1ll870YGXXtAc0GJ6LP7AHCnz2ZKP85jkd81lKvw8f7pzpcITMCbRG1gI+u8S/htbNTeUB
 TxBCIItZdKoaMVFfHIwNPebc3eXv+qyAk=
X-Google-Smtp-Source: AGHT+IFr5uD7fQkoCnD4goSHxaPQhBkxSFe5f0AQzx/maw5JOx8+iIo8wmSVrjS5bNovXD/+iimz4ZCndx0kqCrfl/w=
X-Received: by 2002:a05:651c:1a0b:b0:308:eb58:6563 with SMTP id
 38308e7fff4ca-309036dc3ccmr1831551fa.28.1739297924276; Tue, 11 Feb 2025
 10:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-4-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-4-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 11 Feb 2025 13:18:31 -0500
X-Gm-Features: AWEUYZm9WzNZ7Dgt2ju61I8vQfswHW8B0IA5VrH3cxslbJPWDKxRk_Hw-Tog6B8
Message-ID: <CABD7UXOR-JOqfqtjyDSqFcTUwY6up0jk+UD_AxLuouq33qF2kQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] dts: revamp Topology model
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Change the Topology model to add further flexility in its usage as a
> standalone entry point to test suites.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
