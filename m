Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2642CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 17:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA9A540DF6;
	Thu, 27 Nov 2025 18:56:04 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id A38294013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 18:56:02 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8b23b6d9f11so86512785a.3
 for <dev@dpdk.org>; Thu, 27 Nov 2025 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764266162;
 x=1764870962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr2YhQSK8cnVH/krYmGBZk3bbx5RAqWi7Pd7pHjjjts=;
 b=r/y3f+FywXRiFqho7g/t9QRfA5LfhRNCB8o2Se6UUNNWGMq8Xbxj0dq+DrZW1ZvnNO
 tVyiXBfbjKrjJ9BxP36i55cSijFCpYimCwhssMUfr7S9nCRDNX7XM1TKsX5kMaihXmq8
 H2wPv/0GLA/WmwQLTrRBQnpJJ+0ww3XLWPB63hQNrtdCQUngLX3q9nWNu17G+yZ5fYx/
 tNUdC/pHu/EZqMnjEd5J8mV1S6VmWrKn+MQ4QmzGjDbwikJJwFao+xNJLODzmJQBs3BP
 gLnT7LflQT2LXGDofCyUaCpFPXKLk1D//GHwHMO8tZG58c4I1R36JMvajRHcbcrum2ag
 zO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764266162; x=1764870962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tr2YhQSK8cnVH/krYmGBZk3bbx5RAqWi7Pd7pHjjjts=;
 b=CAQ9dSSLg7YsgbSk9pI+9LGK62+M+BjFBTNBf+7xX75hfhdTE7GHnwD5qvkxcIHh7M
 k/InZ3FX4KUBQBN9owj7vvCsHBgGV2QLySiyI6+ckC5bBe5YpSf42Bn0ZcFmr+CbYdXH
 sfY4zEteADURc9n9hljpWCmTeA0u+F3NP+3J54d8gmCg5LBSy7mRzKi15FFsKFqSdL0C
 6C0ojMW4kTxV0Y4T3MHZ2M4dSS6yleBpTt2fQIn8L1J9+jjbrrgtXb9W4lFQ0QmW2LE3
 b0xubnkou8apfRfCruN/QAJkcZPI0aLYwBa1qLb2GE+uV3ZWIeuLyV+o3ojvcxSqNuCx
 YDeg==
X-Gm-Message-State: AOJu0YyyY3wLn8vpcHUSdkSzJtzYPkLekP5uZeEwDCNaZx7drvOKH7TO
 Sxvw8Zia5+qRGlKYYglACbvz/LZhIdjooUvejyr33kjIqKMfEMN0rLhT7VegAm3DSkeNOYFi3W+
 Tltzo
X-Gm-Gg: ASbGncsjD7F7bYSdGhlzFGm3jkfRDWJGeXHHh3SfYOFIzyjmzYY7t5iC5wltSP66MxR
 b8rvICDdEooraJValNFQVtJE7aawm/QQh6E2gGW2aDsz75t0/E6IAiPj5rS2S6eckD7WG6UNWdI
 kr/l/iy+/zt/E7ziQIL0qN+Qw8+qWg9WwFe2l21NhZ9PXoqchm3JzD8ZoNELJNeefUYfrt+ee17
 MHn7TwtShvN1pwMOzehTgyygvR6D0oHad9c160BY7F+TH53/1MKDxaIG2iI6erGldXOa7yTbvaN
 DgTE+faiY9Uoe9/REgJumQPgXKF5EaozP9fwy2f+JGiZhapCOgXoVXN0zm/TTE2sDQuYOhdLXGI
 HRF2YxUDWqRszYnfMzTKp23HS+IrNvD1RsJhOdjgVXUd4pGTWSyp0NNV6BZxYMBbS4y5GD1NDx7
 bc8LpL/251281jCBnJ4xrVXFOSEjCABMuPPYtgVoG6R97kKbHH2vFz4qzFyit9pFo=
X-Google-Smtp-Source: AGHT+IHQ/G8AGIiFa5jaXbc4yLplWvbFDc/EjmITZCC6RoUl+ML24Kk6csV0/VnE7bFyAzDmOcKzcw==
X-Received: by 2002:a05:620a:29c7:b0:8b2:dcde:b668 with SMTP id
 af79cd13be357-8b33d4680a5mr3341006385a.62.1764266161733; 
 Thu, 27 Nov 2025 09:56:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b75a9sm147702885a.25.2025.11.27.09.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 09:56:01 -0800 (PST)
Date: Thu, 27 Nov 2025 09:55:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix Rx/Tx stats concurrency
Message-ID: <20251127095556.4dfa5faf@phoenix.local>
In-Reply-To: <20251126025436.3714568-2-dimon.zhao@nebula-matrix.com>
References: <20251126025436.3714568-1-dimon.zhao@nebula-matrix.com>
 <20251126025436.3714568-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 25 Nov 2025 18:54:36 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Queue statistics are being continuously updated in Rx/Tx burst
> routines while handling traffic. In addition to that, statistics
> can be reset (written with zeroes) on statistics reset in other
> threads, causing a race condition, which in turn could result in
> wrong stats.
> 
> The patch provides an approach with reference values, allowing
> the actual counters to be writable within Rx/Tx burst threads
> only, and updating reference values on stats reset.
> 
> Fixes: 661c0ccf2512 ("net/nbl: support statistics")
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>

Queued to next-net
