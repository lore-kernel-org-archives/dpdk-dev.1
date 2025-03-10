Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB9C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 16:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E8B440279;
	Mon, 10 Mar 2025 17:18:49 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id E222E40270
 for <dev@dpdk.org>; Mon, 10 Mar 2025 17:18:47 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22403cbb47fso84488175ad.0
 for <dev@dpdk.org>; Mon, 10 Mar 2025 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741623527;
 x=1742228327; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTa7xDmlGtzX8BEVFx5Dv0Erh+KBt1iCnOH1mflS80o=;
 b=f0d1A4rVF5GcixOKFUxBwIRVPDvYBbqed+Do7PBw14EZ5kwfSES+dFYTjyGCBcoD5B
 Z2vAI9k3iR/tTHVT7za3t2JTpgd9jae6gol8cr/chdfMqYNwAfuN6MmOfWfRECtDh11v
 dYKXh7nkI8VBg/rRH17JkcyxRFaZgQOWXt1WkOnSwHW/CGDF+Dow4KGuu1ElCFgNvFP0
 TitdspVuvfFV7OYIDiCr3B8t1VQE44VJ7wm8i9rR7y/dzeUW5QVAtwxPuJdvuqcb0D9L
 +lP3ZlGxfLUmC3t5l3d29bYZVgkeBvWdAcP+SShOtqi6kQXr1Ocz66gf2MBPhvexYDXB
 WvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741623527; x=1742228327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTa7xDmlGtzX8BEVFx5Dv0Erh+KBt1iCnOH1mflS80o=;
 b=O4mQwPcFrYjHZeBADPDOFjOkf1aVwduPsqLqWx0gI4W2pkyF6Ju9nAUYluwHzlq9T+
 +RdzHOzbxmef/Rpv8bKWHT7y8MIawMVkaXifhNqSajzkxdqBaaaI+3BJnFFTg7TX3fKA
 MAWzt0a7b5UO5YXEmKPQAEfkerjuFi9/j9H1LV2ffASyZ1F31afxlIw5xAAzZYq/nZS1
 hgRPF0zqkS3jqeDvF0xNjgDf6AS3tSE2HpmU83on9zQ7YbWL7GOz/5IJ6IsZzOnZoPkX
 eB0mJstSh+7bqFvR9mbd1/FRswVW8qkPOKNkKiqlggcHcSs7ALISt/2NTJ8/EMJA6dX6
 h4yA==
X-Gm-Message-State: AOJu0YxXaIcotXuy+YOiE+nY0BQOqgIJLoUT8K4kueztFoDQK+q2S9XP
 tMY15YuNNif610bHrAIEm4Gv7+KT55SM17EL2FA1HrrzRfVoTuBYhVBPlzaEIUY=
X-Gm-Gg: ASbGncuPyJ4VS79sYgHXLr1T6FHU0FWsBXrpfJlHyX1naczFOgAwDkpZMPHnV4E1RbC
 rGPeFi1s7sIQwkXCcFBu8+gPfdVAiNAq4AnKJRURWklK11W/ZB57PmPtMshM0UU2A3/vlFr3DqV
 tf2anUlzYpsrLwpbzKk+/epJDsug3G/3wSCnYNMIE7ElzkWw7j1U+VEr9LND1uEVKTuwXoXPo7W
 Aa6iVtw0H89ewULVlCp+T8yiDji6/xY3dPDZvBgqx7w3pFTIHCibQP6Mp48+7VpgR3O6V7viM1e
 9B54PUewXMlqGQb1j/h3PHcAZR/wO9kkCPOxvrQkcsGO5z3QsYAvoUcueQY2tK1t1nmlJsMKlft
 FC/NXrYYo74EE4iVu5uvwxw==
X-Google-Smtp-Source: AGHT+IEQGLW0SZnkUFh7A0aGqckihi8AeLvO6uPpxIEDdtBqK3skqqbF0es7YcN3vwZQWcuUVJg+7A==
X-Received: by 2002:a05:6a00:987:b0:736:34ca:dee2 with SMTP id
 d2e1a72fcca58-736aa9d389fmr19157046b3a.4.1741623526669; 
 Mon, 10 Mar 2025 09:18:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736e0c8c846sm1635918b3a.123.2025.03.10.09.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 09:18:46 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:18:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <mkashani@nvidia.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
Message-ID: <20250310091844.4a3ff0d1@hermes.local>
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
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

On Thu, 6 Mar 2025 15:37:13 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> The patch converts include files with DPDK API to RUST and binds new
> RUST API files info dpdklib package.
> 
> The RUST dpdklib files and DPDK libraries build from C sources
> allow creation of DPDK application in RUST.
> 
> RUST DPDK application must specify the `dpdklib` package as
> dependency in Cargo.toml file.
> 
> RUST `dpdklib` package is installed into
> MESON_INSTALL_DESTDIR_PREFIX/rust directory.
> 
> Software requirements:
> - clang
> - RUST installation
> - bindgen-cli crate
> 
> RUST dpdklib installation instructions:
> 1. Configure DPDK with `-Deanble_rust=true`
> 2. Build and install DPDK. The installation procedure will create
>    MESON_INSTALL_DESTDIR_PREFIX/rust directory.
> 3. Update PKG_CONFIG_PATH to point to DPDK installation.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---

Re-implementing test-pmd, l3fwd, etc in Rust is OK but not huge leap.
The real benefit would the ability to support PMD's built in Rust.
That would be much more invasive

