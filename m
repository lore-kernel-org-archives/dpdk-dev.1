Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92122CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9EDE402BD;
	Wed,  3 Jun 2026 23:44:43 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 16F1C402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:44:43 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-137dd3af345so29650c88.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780523082;
 x=1781127882; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XU6Y07z2L3aHjnKutayBoyG1Q8Ch9K3qCadfFkrFXPo=;
 b=ZkS1e/8MvIHNr30DTFVaK/gknovHSB6A3jXu0If6oomERFsw0rTlGs6OdHjeFx08wq
 YA1ZZtwkCIXrUht3Evwyi6x33ALbmxLKsNLvtztOX61C7A4gF2O+ZS+08wLolrRzlxr/
 EpceH89/fmS2Z8BNAD23IfK5o02ZfcHYyekxeuxL0DleKkAA0DLQZijqT2/CljJp59bf
 oKy6ALcbSxjKnnDs0ogNEdWrcikMYTr6T8mP9cQcmvpPDDDOhv0p8d0xoUmJJtJK6uS0
 afDv+JE0k2Jyu5okEqlY7LGqwKJVAo+0NoY8I454OMJ/DTLvW21mYysPjOFe8MASzLhX
 b0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780523082; x=1781127882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XU6Y07z2L3aHjnKutayBoyG1Q8Ch9K3qCadfFkrFXPo=;
 b=RqT/WjiiwUZD159bWNcWc2coKbAeYr1sVeVuE/AcwkYbacmj9BmauAhhdzviRqu9Ry
 ra50n+Ty6CR2jHZ5K6m5/o+CNPGMsFSPaYCopYweNgNHfVvQxj7f/6ZtuRkLAa4sou1Z
 9EE+G8GmrM3LHGNDiBNGa1Ze2+U8y73eYT/6xMamOoOjHcRWg/yH25yYTc2t5HPv84y6
 e50DP0ZnoKsGvF3deVY2VqORXpRzIrSCyUFD7RhUmlFBhmpKlX8FlMWOgENCiFkz6/ye
 IXpelg5mwP8UjxkmKHeIDfUU2HtnQ1e3V4CV03whsHSLqgkGGpVkkcqvhWdwPfujE7h2
 qo3g==
X-Gm-Message-State: AOJu0YzrmVWLioS7VFt1zEH3KXupRzxRcoha6XkkSXGa0rpPepDvVlbT
 oF7sGBDdoKs53m/UwwMe89oq3sqstaB4zFFsuSkT/uyOmiq/hIJDuJwI+gm0h6TUXN0=
X-Gm-Gg: Acq92OH8/BONM4NOe4nzqvnPXl98moVh3Bbo8TTmOAW7myO4bTaPH9XonXtueQzH8x/
 M84eTyOTr/K0fFkFmPcg7xuzx6pXnZy3Us3O9xiJ8KaYoqt/ZOAqVn3JwYiI5LXA2sHQplMwYEr
 FPNMuJ0g1vT3LWLJPzDmfnrso1Crci3NkmJ+IrD/AN400rQDMIOt6v4O5cReP5U6qgJFM6qsQRS
 QKEygWWw7i2NzuiqONvN6vMprYKE4clTuvcfJ3ke6mqxvv+fy+4Ah2am/jP6vLnY+WofqJer8bs
 BeUTBrhf95Iqjm+AfhXfJX+LeZWXroXJG/UkrAkIvLOLVsxILqy66BTkIE1jNNiw6/ZHh/h1Qdy
 t15OuLynQ7/Q/c/YFNoPK5GKjdXZtdqC4xsZZ13GWolE7mIHm5gnTPD9e1AQ/6OUnCl3jtOGGMy
 V21+o080wLV/SwQNvIiU2tHJgBT+8Dwo8R3+wQdgMlaNjSJXaOriT4w55o5N6kjfQVV61CqQRHb
 h0=
X-Received: by 2002:a05:7022:238e:b0:130:ca3d:f963 with SMTP id
 a92af1059eb24-137f6c4f350mr2274046c88.41.1780523082098; 
 Wed, 03 Jun 2026 14:44:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f548ade9sm2571673c88.2.2026.06.03.14.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:44:41 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:44:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, stable@dpdk.org
Subject: Re: [PATCH v3 4/4] net/bnxt: fix RSS hash mode configuration for VFs
Message-ID: <20260603144439.13289570@phoenix.local>
In-Reply-To: <20260603200207.1996868-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260603200207.1996868-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Wed,  3 Jun 2026 14:02:07 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> 
> Fixed VFs attempting global RSS configuration which is not
> permitted by firmware. VFs (including trusted VFs) must use
> per-VNIC RSS configuration with actual vnic_id and rss_ctx_idx
> values.
> 
> Fixes: 8b9adaf0da6b ("net/bnxt: support RSS on ESP and AH headers")
> Cc: stable@dpdk.org
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

If you need to update one patch in a series, you need to resend
the whole series. The CI system works in patch series.
