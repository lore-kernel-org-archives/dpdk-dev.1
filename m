Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2473CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3ED74066A;
	Mon,  8 Jun 2026 17:30:29 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id D7909402DD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 17:30:27 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1382533d428so348373c88.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780932627;
 x=1781537427; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmXVxhA99g9bRzczXV2M/vV8nKf4x5o9XRHR8/6Gyrw=;
 b=RDsScHAVOEcENkTPK7ChxUhUFzJfANzeyMs+Of+maBX0sZaAqoc5WZKnTViTRHtAXN
 VTCGKzG1J2N9n/8vXtMU2bYtTShI/cRa1mgkni5f2IlsSVB5cgweKrhrvwl0G22iLh4t
 ta+CcoiFZZ8sCCHs3AW0DEWl1Nu8OHGC6oWFW2RHjr8tQdX48e7qWfkmuLBRlZcr3QUa
 udiWnk0wxb1Tdla3+hfdZeiNHJaE/3quiwI+vYjxs+GFX3+zJ/uE+9dz0RnVv0gM+xWn
 3Xlkb47GQHN9/XpKn5FU3VfPMsEh3rWQU6B0wBvIa4OE+4DF/wl+yqeo0t3CHeHDflkv
 eplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780932627; x=1781537427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PmXVxhA99g9bRzczXV2M/vV8nKf4x5o9XRHR8/6Gyrw=;
 b=XMpSwlCq7soh9pzFow6DlJqdlfRkVDtlD1RMh60KCuFG0UafTHu8Tp9I6+yl19r8Fu
 ztddWecfwntA+Et+EVwU9RufXAfWdvLvYVmaDxUq/CnC5625QBverEntFM15hXjX9LpX
 MWF4GSYlXIV6iaQz+NbKozxV9Xj8o9Ox4rP1IHw/7Uc1WOMOO/umuktno6UuCbs9ooH6
 N22cuZw/l+VrP5FhDEkBNgf+e6sf8tTCgX7ZMnpoo5fApfWtP5UgyyUdYrwgxExBtesT
 tZGbgv/qSTIviQ2xYu+ojYpE6BHDaKZq4F2iA1xsB8fXF3DkV0gDVvc4Kpyuw5ghSl4+
 ZO5Q==
X-Gm-Message-State: AOJu0Yx5GVy/wooWQ3nUlJbrennxX1mQ7yr1bz2ABfz0DGjTz/jvrH3C
 DEA5E+TvQx1Mu1V6RSHVK6Q71M0JWTBptNX1T29rM2ojfiZ9lfbxsIbiwydGMiQZHcblMwELG07
 VwkJi
X-Gm-Gg: Acq92OFYV0+gyowj0gLeOFdwnqG8RZcreslgztcQvFy1YpDq/SSFI+0gVcHQP5SnUXY
 UHGDVYfryDBePW1X0hgYDu2F1LduZRaz7LtVMkxe9BqzPq1x8zrFLWU+aVIH5EDn+nVJgMAN7Fk
 P11uBkMKiWOiUXAOGQ99BfahhIMNgieTOg553FWc/cOHGHF5e49WlgFQwBXKioH6UIqGp3t3Y3s
 zlf54kUqWl6/1N9MYhKgAaVjLOxHUV2EqvgXhPl/P1FDgsumjhwKpkXB0XJMxY85x4CHwkxch+z
 1a78C0grt8o54GVa7a88+L9vMxk5tmDwzDtsNFhxN7of7M3vzS+4BaIw7oVqjkIuNxh+34VxN48
 v47CcZ9fAU7VpV6YKlLFXoO519oNEnKMU6lhVSBB1l3G05Lbu0htBspFWhCPXXRKp8TcGAdfSBc
 5zbilxjbw05tAsqMjX0GC2uv/8PqfJd21YQelgLADiFZEI65NwGAeaOQ1p76Pc1qFed4/1QzGbI
 qk=
X-Received: by 2002:a05:7022:f691:b0:12d:de3e:52c1 with SMTP id
 a92af1059eb24-13806736287mr7745555c88.37.1780932626624; 
 Mon, 08 Jun 2026 08:30:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f553ab33sm12080959c88.10.2026.06.08.08.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:30:26 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:30:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, chaoyong.he@corigine.com, stable@dpdk.org,
 sdl.dpdk@linuxtesting.org
Subject: Re: [PATCH] net/nfp: fix null dereference in flower ctrl NFD3 Tx
Message-ID: <20260608083022.171d9f92@phoenix.local>
In-Reply-To: <20260603055211.120315-1-denserg.edu@gmail.com>
References: <20260603055211.120315-1-denserg.edu@gmail.com>
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

On Wed,  3 Jun 2026 08:51:56 +0300
Denis Sergeev <denserg.edu@gmail.com> wrote:

> In nfp_flower_ctrl_vnic_nfd3_xmit(), when txq is NULL, goto xmit_end
> leads to unconditional dereference of txq->qcp_q in nfp_qcp_ptr_add().
> The same goto from the "no free descriptors" path incorrectly increments
> the hardware write pointer despite no descriptor being written.
> 
> Replace both gotos with early return, removing the unused xmit_end label.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a36634e87e16 ("net/nfp: add flower ctrl VNIC Rx/Tx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>

Applied to next-net
