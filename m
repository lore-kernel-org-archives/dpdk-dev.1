Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17D3CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 17:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B285A402DA;
	Mon, 15 Sep 2025 19:53:14 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id CA13C402C2
 for <dev@dpdk.org>; Mon, 15 Sep 2025 19:53:12 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-776aee67e8dso11222006d6.3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757958792;
 x=1758563592; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GQ8hKFCXQbtEuWQwWL3AH+PLqFdMhPrN6Vp7j8zw7o=;
 b=E2kGMmWBb2zEAVHSt3IX9BhkOTIOzvdmOS8PwB2PJ9L/U6aRLkKpOnjaKNZWOVImAf
 e9oLSGqV43mJoIkWq82OgklsgLb5Fa3q7tCbaifPIKoEKPXaHi2Ncl4ZSzCHwrTiiBe5
 KtXbeC0cgKnVtBf5KMe/rGz9e/IzpUuOouO8wf/yh+pfJXLsapnVULwI13v7RFwOwVf7
 AsDDjQZpctjC98FQqhLt3vfq8bPfTKd5U+oyyTsuTeeE9w8bo0hszWSaF+w39UIOn7km
 rNnLgoyRxOauQe42nbW7F9jW9i7UmLwhcFgx8WZ7CnRRceN8KKTfdgImge5S/6IvkAZk
 Spsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757958792; x=1758563592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GQ8hKFCXQbtEuWQwWL3AH+PLqFdMhPrN6Vp7j8zw7o=;
 b=KXyiKAaIo2oMuJPg1dGvLaBU3cSFx/Kqv1B3jFQaYSkkGrqpKNgRD3opaW8OHZoXG+
 qq6tZLGN2Mhh0xsR+zBZLAtiWeRmkRIZfG5sQ9c9gkT0qBexft3IMQsp/9bOMsvnup5I
 R139mueh/Uzg0VEVFPKiDqk7sBrdM7nHbBDwPYd6bVO9jBosaJCqPXSOq/1dOhs+dFEx
 SxJWKWApC+G1ITjQAR/Sx45JMLYjckLbbExC2CAgZsvCA8NpJOcjaeH0HV7PbT/22FZ5
 9g6Ap0yZ9pz0bkmtQ3SowERziPzugz3G+gimyKhXr3KnAF9HbYQAODaOXDUxANpZAp6x
 cwLw==
X-Gm-Message-State: AOJu0Yzp6jJzRyyV8JBdw0HU4zH62TYub8k8htmR6KoaYF491qz13J1C
 1NkdoeLj7YRTYBz5d6XIONOvTk9Ug8c9ibicR4bjSEMET8DFqDGiOB9C0naeZIuuIF4=
X-Gm-Gg: ASbGncvjUtkKkglkzyQ+kuXpt4hVJejdpda61zLQnN2Vr/F159ygGWR/npJ+mqlTfi8
 hE8FPXOrVuJbWOghK5FrSbKS+rh3PNzV41xNHd2VaR790QBFMSo9kH3KXnoUVuIXP+joViFKmFS
 ym18w6peRyOGM1japEJFe3mtLSORMwgPWVYGTTq+XR7r9z4YE2mMWbS+TKBVXe+TxRteS9BnZG/
 lt5KICAe/h2ACf9gt/Tc6lfg5pU1o4uOTxCQmzRhg6vTErugxndzQYBFN9te8GrtTrHN/nkrEW6
 Uht5pqjALqNEocTfBng40oEAuX5/eIy9WHdUAlQhbVuRQhJyupypC5yysWirnzZsZGhOSYCDNme
 cnEnRg87h58yYwq0rF8Y90jpJaARShcKgAcgC0yItrBelIbjx9IxWY4OqSUbnaZCT85A+ur+D9s
 4=
X-Google-Smtp-Source: AGHT+IE6Ytp5fXXpSv1IbHa5TIzOLeccn+ocOdNo8nF+xZfDxqNoOgl7Rj6dHN/mTtqFZYfbA/tKVw==
X-Received: by 2002:a05:6214:1310:b0:70f:5a6d:a253 with SMTP id
 6a1803df08f44-767c4012078mr165613166d6.49.1757958791870; 
 Mon, 15 Sep 2025 10:53:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-776eb8a9cacsm42116346d6.29.2025.09.15.10.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 10:53:11 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:53:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] app/testpmd: enable warnings for possibly invalid config
Message-ID: <20250915105308.46c31d44@hermes.local>
In-Reply-To: <20250912160210.388290-1-bruce.richardson@intel.com>
References: <20250912160210.388290-1-bruce.richardson@intel.com>
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

On Fri, 12 Sep 2025 17:02:10 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> When dealing with multi-segment packets, there are separate offload
> flags which should be enabled on Rx (scattered flag) and on Tx
> (multi-segment flag). Print warnings on testpmd startup if we detect a
> situation where we suspect the user is missing these flags, e.g. we
> allow scattered packets on Rx, but not on Tx.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Should also check for RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT which should require
multiple segment support.

Could testpmd also check the descriptor limits of the device?
Does it validate nb_seg_max for TSO, and nb_mtu_seg_max for all cases?

