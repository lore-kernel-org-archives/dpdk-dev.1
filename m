Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7754C109C057
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BAAD4161A;
	Wed, 25 Mar 2026 19:54:56 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id A456A402CE
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:54:54 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12732e6a123so396188c88.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774464893;
 x=1775069693; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eED5etOvYCPWFnc6y7Noa0rUvX07jwonGpuMgERjEME=;
 b=u206jcHylT7ezXs8eUk9/oNLngwUpnPwfr8phJ8Xkv1O6jPQDAnKE27n9Mu+Iox2Lc
 /TvcNZEFSdl5aCvo8lKwe8hvNpBwGUiXcmRJrO9FlXisUMD5R/ZW8ZMMiqdyUe4AteVs
 BVnfbLScU0OEsLRtFCG0Cmft+rvyRHul+okoAuIJxapx/Ynk7WlTEnvrk7Xlw0ydppXH
 uaq5lUn2JbER36BvjvtKP3LAMJcuBhpaO2A4F9AqRq4+9cjZzowBiBYkdXoxodfqNASQ
 NxbF0QdlODrvpLMGDob96kWP3Gs7jnllauUkx37t2AmQFWs6JyRupnobfcsDP2VgulEE
 753A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464893; x=1775069693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eED5etOvYCPWFnc6y7Noa0rUvX07jwonGpuMgERjEME=;
 b=EIveBf4rPYfL1F9zIL0W+SyOZPAXdrjTK5JW8PTJ1lsO0lWoGq4mWveUgBIwGaUAtn
 ipLqeA5U002BbfvgyZAVBIa2LmXRNF4Ym/lV+ZCQAkKc7Mx2dJHCHf/KxMRar58PPQWZ
 3sxEFqYPqL/NnRuWH+PI8iFhkogoXELrcfP5QFrRautj+JstRP/Q92hKWgq2mVw6a+PT
 UT68KqLfZvvJRIZo2x9Z4FrXmhs3uc9ongjktde1g6BGoOyFncGUtfQQiMrqd/mds3KS
 0xS3NpXXqYa4kBY09r57ll1lUAJGeAgC582hLtf0RP2OwAjmUYuvLiHh6/82bX0nJgVf
 EqKA==
X-Gm-Message-State: AOJu0YwQY1QozrLOvxxyNon8Bq3faX3WHnkWK35ze9j1lcU1U06Wrwew
 yp1bs+iNQ+eFE0M9QmYckv2Y93HhsZYBVJiBJXaFvWwRD7ZaAQ7Al41YUCrNCMrhtN0=
X-Gm-Gg: ATEYQzyGyt+titeMkOwrv2NNcngjpDI9/PTItf6bRRgoLHZIx8VDHtjKkzy0VxZIWyG
 GhkHWjz/c4oYv/YDhOJSkAYbwgjTnjAqqywHioLvdmQHOy92v3Tjyd/dvikjEI7lmBVBlGG0/Gj
 zUOliwvPR2J+2jmCw1rPWDEFhGIKB18oqTz6HjMey1ciHZi/Q7hBKUa4bABgoUWcUia6ovs41Fc
 gZu3whsJpv0K+XHgzfFjvkkDopc41OwsuH+VsDyIAsumVPTZa1hwnMs41YWa8oKtrG+BcEcK7nK
 RRn9CXH+1o9Cn5mfuR64VyQpmqeZYf19QMlVHzPWIvgg12+/spxN7B+ZavHEMjB2dJnJhN6sR0+
 9LF9Uvh9zxBMkPw0VyNceh/i1FkVioL9HqnfX8cfK37Stuwse9MxAvAwfxeMCtjg7BhXmgq1TNl
 x9BI1qZOvqZqHy8cIb4R6d7iZPtZJ6RlWj+E0=
X-Received: by 2002:a05:7022:b9e:b0:124:9acd:3b15 with SMTP id
 a92af1059eb24-12a96f0ec3emr2568573c88.39.1774464893505; 
 Wed, 25 Mar 2026 11:54:53 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa7624247sm803213c88.11.2026.03.25.11.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:54:53 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:54:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, weh@microsoft.com, stable@dpdk.org
Subject: Re: [PATCH] net/mana: fix CQE suppression handling on error
 completions
Message-ID: <20260325115451.4120982b@phoenix.local>
In-Reply-To: <20260325183836.1925080-1-longli@microsoft.com>
References: <20260325183836.1925080-1-longli@microsoft.com>
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

On Wed, 25 Mar 2026 11:38:36 -0700
Long Li <longli@microsoft.com> wrote:

> On error CQEs (e.g. SA_DROP), the hardware generates one CQE per WQE
> regardless of the suppression flag. The previous code honored the
> suppress_tx_cqe flag unconditionally, which caused it to skip reading
> error CQEs and misalign the CQ consumer index.
> 
> This misalignment causes subsequent completions to be misinterpreted:
> valid CQEs are read at wrong offsets, leading to spurious error
> counts, NULL packet frees, and potential use-after-free of mbufs
> that were already completed.
> 
> Check the CQE type before honoring suppression: only skip CQE reading
> when the completion is CQE_TX_OKAY.
> 
> Fixes: cce2c9df44 ("net/mana: suppress Tx CQE generation whenever possible")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Applied but needed to use longer SHA for Fixes to meet current guidelines.

Fixes: cce2c9df4481 ("net/mana: suppress Tx CQE generation whenever possible")
