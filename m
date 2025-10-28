Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA8ECCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 13:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F28A240659;
	Tue, 28 Oct 2025 14:48:06 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id BF7A84021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 14:48:05 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-290cd62acc3so67757255ad.2
 for <dev@dpdk.org>; Tue, 28 Oct 2025 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761659285;
 x=1762264085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWQxTw0GxR+6SBoKJ7V0CO2f9AhUj+Jx/A+ULRgCJuQ=;
 b=HrbJ3ToAZCvp/f1rHIC70ZbtF60GxKQe3g97ujauKfCq4SSKy+tAnSZz36RdX2rOZF
 0BdLwEydFndroGQdv3CVnBY0FdQ523OGblKoKF/+cp2Ro0uD7eygnnYlkSDUqo4TvZZm
 XGFDa0LY2aHIrj1/Y2Q/aQejmNMFJMx+M3gHeJFSw2WLinpsQXxcw3QDoodzmOuGZt+W
 edwH/AVpB6kESvCBmGeZ3kymCLxclCC1b1/TWe7qoGGVERyPpGPNWMpJYX7BGupfQdko
 DJTRxwvdNWKqesarFbjkwH92x1e4tYWMhRR0O8YYJm2thFuPnACHqHCEP8OGLdWaZj4e
 fpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761659285; x=1762264085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWQxTw0GxR+6SBoKJ7V0CO2f9AhUj+Jx/A+ULRgCJuQ=;
 b=QzBw5W7HFOGt49UEtyFlt1viDVq1oNzyqSDLUDF0VLGm3dNyvcSiDrQTyFYB24OIW+
 Y1yMTpHhIR41leirMEA1PRfiYxjOffWAhtvK21Yu+26rD3lEhzl5Vi6lG67GKYNEP53J
 Mqx8Veukw0b5LzJAwNcv7LuX1DgaNQoHkl0mPZUO5sLO8oP1KfxaY719qMN9pB0oiA+b
 UZ3nTnli01YVUd/eiNd5JU0PkKoHHvEnIpdl4Uj2ThdThNI8O/PNtE56iWJ1FXkJWurx
 fGRr/wixM1V7AtAygYlyDMMJe9513ldfs67TZfB/7nYNL5lRtzBBQ4VJ1mvo9mnOTzXK
 jBtA==
X-Gm-Message-State: AOJu0Yz639Q4LSwRl2KVKxPraLl2awlj46M8vkKlzdoffCO/Nqg8Xak/
 3devNiyumAJuZ3H97lftAjafdhpEgcnlX/UAWhkbRz7zv9WvJhDAugxi4RROX9M5YCs=
X-Gm-Gg: ASbGncuU8+Yos+gTeynHP4HfaJ3OM4gAqHEdtTeJeIPuJr4cVwp/K2ewbJ+bNtoXOrN
 ceeCiFKGziIxCLaiO4maYCLZFBFRzMFkSpS+FliP2+cKwumYJXfBDOb2Nn2MvyenSOj8NKcDlmI
 2uL4X3PcQQA7Lp5B8bZ2Pmh7xmOzNNcQboqekaTE0KhjIEIo1vooH18XLRreUotD6eftfGScWUg
 aSQ7ju6xVOO3TEBcE/dby5ekSLePLbwBtpSHo3u8ctX/WOjjmTCDQG1HX6q5rhU/g01tU0WY4Ok
 yMvEiIJysEmILtpxN5hdRLN9PpFQUVjuNVLlG67ArMp5VNUXdRAES0DDFLUyM2uy5LXsQ8Q8Jjl
 ioKIsr1fpBnKbG/QEooT3G/iWj0ZjlZiVyfyMFBz/ltIPaEibb70do+0FSSI3lxqWnP9XWb1yu4
 nSlKpSGK/RNPqGzugNyAHS/uu8h+JGgkWMrllbd1B9ImrY
X-Google-Smtp-Source: AGHT+IHyoswa4cU3YTvrT7c1pNXAxzxL5DNox/YJY6W8lnIW/k9FxZsaM+zxjaehscgJdnoUh1MD+g==
X-Received: by 2002:a17:902:e5c4:b0:28e:7fce:6685 with SMTP id
 d9443c01a7336-294cb525581mr45691225ad.32.1761659284900; 
 Tue, 28 Oct 2025 06:48:04 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3402a5ba7fesm1201848a91.9.2025.10.28.06.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 06:48:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 06:48:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, thomas@monjalon.net, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v3 1/1] doc: refactoring the guide for NTNIC PMD
Message-ID: <20251028064802.6e573b13@phoenix>
In-Reply-To: <20251027130002.597552-2-sil-plv@napatech.com>
References: <2974305.OYXXYNVTWy@thomas>
 <20251027130002.597552-1-sil-plv@napatech.com>
 <20251027130002.597552-2-sil-plv@napatech.com>
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

On Mon, 27 Oct 2025 14:00:01 +0100
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> Improve the doc formatting.
> 
> Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>

Queued to next-net
