Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AE9D111A8
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 17:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D69D640E1C;
	Thu, 27 Nov 2025 18:56:49 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 992954013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 18:56:48 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-88054872394so14162086d6.1
 for <dev@dpdk.org>; Thu, 27 Nov 2025 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764266208;
 x=1764871008; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEbcNEFEtkumAZ6owN8UqmHJCJbxmcFUg76JAUOclTA=;
 b=wsyNyZTsIxBzkXfyGS3kkFMSlBmcnH1BPMBvuuAl9hTTSetZkZ8D+wOiFGy29wtIip
 uCwn7bRdFmE4ylSVyszUr6tEiuEgDLnVhZKB2iSVAPZRFrxyFqguDcdoT13vnusiKW7K
 FfCE3k2+dJVs8WQ3/FvCpBp7U4DO0l9wpKLIr/1zZWfLnnYu55Hw2NajEBEcQVAcEW7E
 Xx7OIiTBSdZz0TE2qnThBgP//1gcOiP0ifDkRZtuDpBpUkwVUINZju5loOCF6kMl7/l9
 n1Tiap85EfqrhOFP7oD1R2yxJviiTymPP3/Bpsnxn5ieTx1AkAs32bPo+NsYRtuvUuH0
 zKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764266208; x=1764871008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hEbcNEFEtkumAZ6owN8UqmHJCJbxmcFUg76JAUOclTA=;
 b=Bv5xVBclYaqR4crOKEyhwshTKyXVmjMmUQ64lPyBM4lmdq9e+woseqTlqMqKj/B91e
 8wNYULyxzoflufopn6OuG0J+bKv5/Eb/BDLaUvSP3BO+Udz8OYEhQr9vVBqKFKkLPe13
 bKuOvEb0uYtz8XNcadqcsWgOGdQ+O8Z+Bh93jK/EAE/Mo/ehJGB6qWhyo6+RF2Uc6xJw
 BTXTW0DEOfhY1pZYD9S4PL9sr10VpOuyZYSpnYI0egCf8xZqFu8i8g2YZp9y02pfKfEW
 5kf1HiorinHWCLppiKlSwO/5YjEV/38GFCH1ZN2PK4yCfE1HXm+WrrTJkubgx/2Bi388
 hA0Q==
X-Gm-Message-State: AOJu0YyAWDLHi+ia9OhYuz5nzAbm8itVZvQRjoiUjJVIZppsFYy4lZKp
 YyTlu7Xzlb2HhE5MUWPT0avWmxLoGJwN2Bb7dmpwRiYdlR8vmLBJgylj59K/IWgywrI=
X-Gm-Gg: ASbGnct3fq+pjM9bWUOj0R33wT7tjmEW++oFXu3/MXfdvb/umqfnuUkrkBmyNsn4PkA
 g1CZruoEnhs7v/LIy1AGafgewWA3L3xyRGXrNrKaUyl2AvvQN5gay5n03jaQ073okq6dQuR6fsD
 RuDcf/DtrRkEd1d8Z9vH1QqEi0RPf1GBanFBYtZdNCs449CIKUV/enNEyZWmqMbJIBKfBpWOufq
 hrZlz7BxeD2lb4IH0oI1rSaek68wnHkNf5r1Kil6RZhCV5c9Bf1Mo/LlyyTgFMeSxgpuFVv7NTL
 DIM+z/rxKRFo37JHK4gvhQWldYyTmfY4hxcafyboWaIcre/Gwhmz5lIYZTsU7+n8nsbXrGEfRfH
 V3oVtBmqL4iXAMtmn9BpXR+nkX5Ffquwd8D5f7rrGXg3JjHjwGE3iCqhJU0R2R3e0lJZrgJIKsT
 JRmmqdXW5aIR2tVEueXxShLXbQRdolhf/fqnGEB29YwWa0kCypZCNg
X-Google-Smtp-Source: AGHT+IFceJN9J+LG1mAFjrcagdkbNH9A/WIjS9HxpeyPbFakZnSyt8bZ5hgm+9ZIxO5OGagHi8byYA==
X-Received: by 2002:a05:620a:3952:b0:8b2:ea5a:4152 with SMTP id
 af79cd13be357-8b33d4c6f88mr3185959085a.87.1764266207798; 
 Thu, 27 Nov 2025 09:56:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b5299a534asm149847885a.15.2025.11.27.09.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 09:56:47 -0800 (PST)
Date: Thu, 27 Nov 2025 09:56:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] net/nbl: add VLAN offload set interface
Message-ID: <20251127095643.012d2ca5@phoenix.local>
In-Reply-To: <20251127003821.76733-1-stephen@networkplumber.org>
References: <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
 <20251127003821.76733-1-stephen@networkplumber.org>
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

On Wed, 26 Nov 2025 16:37:14 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> 
> Implement the vlan_offload_set device operation to allow
> enabling or disabling VLAN offloads through the API.
> 
> rte_eth_dev_set_vlan_offload() calls the driver to update the hardware
> configuration. Because this driver performs VLAN stripping entirely in
> software, only a dummy implementation is needed to avoid returning an
> error.
> 
> Validation of unsupported or invalid flags is already handled in ethdev.
> 
> Fixes: 9d7757dce874 ("net/nbl: simulate VLAN offload")
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Queued to next-net
