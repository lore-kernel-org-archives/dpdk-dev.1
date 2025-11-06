Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FDCCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 19:29:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6537A4060A;
	Thu,  6 Nov 2025 20:29:16 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id CEFF8402EA
 for <dev@dpdk.org>; Thu,  6 Nov 2025 20:29:14 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7a435a3fc57so6912b3a.1
 for <dev@dpdk.org>; Thu, 06 Nov 2025 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762457354;
 x=1763062154; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUQpi2TzICmJClUbAIAmRqiGG3j2/JCGhWt8iXJLe8c=;
 b=LOYEIMc3APd/JBtVzw8Q6hT0OEy/F19MgjYxrqeaO18Uuw8OXUNavtT47i3bnDE/rK
 pRo20IXqnCESaxooiU9sD7LsBAC7314j5QuFBfyeXmK0tHoARQiS+11bynQy+bl9X7Zd
 efNsZJ0KMn5RCAjQmn354VmemQUCIO99E2mFPotoGMarrUQKEfYds+r2ElKDfWkfwh4v
 6YBL2QNKf8iGzg0Fbnvz444Gtl3bl/VqSm+wsiK9KohvnyrUFdYqvVEOu0rHOXgzJsv1
 xK7H/tkoyjfZQs77nhUC4nok0TXsgg3YZjjcUYITYMPHEIm9ycSmW6EWHx02XXmTQ3kJ
 AeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762457354; x=1763062154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yUQpi2TzICmJClUbAIAmRqiGG3j2/JCGhWt8iXJLe8c=;
 b=GHbKZNZ977mmRkf+HnreMWDlqkf4q7gISrF4wSFujF5bygP8bhOXp3+/b4HCW3PwBE
 4v7J7aQNK5JFKOmSHQTfm1A9DpXwx6KOKfoccWxt/x3lCQQFnz6BCtJXyw9a+6bDW2rs
 1o+A900BIcIfvyh534tXx4HhxpHs+OyAQAvIlGYhOzG8t7T4tjGx3yLf57++cYAykV11
 +FNhEz6ptEboIvouEgh05azG7/vm/aVlPSUU6SlAYuSsKdehrmOTGProXoP2Ieu+0WvP
 zMSKJSqI22vPpo1URcbvsoa+vD1520GKctUggTRj9KIdnvo1wSP3E6V2mS8INBkmljeg
 3DPQ==
X-Gm-Message-State: AOJu0YykhvWguZrxG2T8eEOYsAFdJdzQTBwXnk8bvtyL/r88HPFklVH+
 +TRmy40L47ZUTdWNP1tmhLyUzbIYES1K5NYNoIEVYt6/2K4nkmvD18rS4kMKFRmZTBM=
X-Gm-Gg: ASbGncsiqiLXsf9q5DsRxnzwWOMs8UcIA/qM5MJOtnfS8cqVq2iSgSVJomX30AP+4UU
 UDRLGEIJltupl4aslaXsuJkxCtMGdpOCpY0lDl9cTOy8qiA5mc/z1KQq8G1kL/o4kA0SvGbM5HJ
 6S/LFnqCoQQHQOOTMrhcL3gJ3PKG0pyEdAANxR7RessLByP9TrnGr3RlYh3uSf5QWfoNOvI29Ay
 NFsqIauqEsEqcSrmL0fsbySETAyDL3utWH1yVB6+q159mfp7s05bppvmAnKRwRYqnu1kUC6cYst
 Ecb7Cdl0u/0d9ItvH+vZJcaOFCLhq93GPzIATujpZbmXFXnEiVX7waooNezE5bWd55pL6jtLkNZ
 22/62ipuQ5S43KGpB4MqbfyOixYPixlWm2pFJ5ZYdRdJ6Htv1FFuFI5KUaGlEMnYFkLdR8P/IWg
 ycNqqN2BDVTJPyddnBmwWtPPzWn9nZ1sirAA==
X-Google-Smtp-Source: AGHT+IHKK+5NGuKlY59Cu6n7ygipU3Cs/Yxv/bzDwTlm8ZtIGf+YE6e7Z4LBrH2Xob7SjCkJlMlAJw==
X-Received: by 2002:a05:6a00:b44:b0:792:f084:404f with SMTP id
 d2e1a72fcca58-7b0b8cc352amr934587b3a.0.1762457353877; 
 Thu, 06 Nov 2025 11:29:13 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0c9f01821sm340660b3a.26.2025.11.06.11.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 11:29:13 -0800 (PST)
Date: Thu, 6 Nov 2025 11:29:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, Maxime Leroy <maxime@leroys.fr>, jun.yang@nxp.com,
 stable@dpdk.org
Subject: Re: [PATCH 2/3] net/dpaa2: clear active VDQ state when freeing Rx
 queues
Message-ID: <20251106112911.0c50107b@phoenix>
In-Reply-To: <20251106163807.201451-2-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251106163807.201451-2-hemant.agrawal@nxp.com>
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

On Thu,  6 Nov 2025 22:08:06 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> +static void
> +dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_lcores; i++) {
> +		struct queue_storage_info_t *qs = q->q_storage[i];
> +
> +		if (!qs)
> +			continue;
> +
> +		if (qs->active_dqs) {
> +			clear_swp_active_dqs(qs->active_dpio_id);
> +			qs->active_dqs = NULL;
> +		}
> +	}
> +}
> +

Why not use RTE_LCORE_FOREACH() here?
