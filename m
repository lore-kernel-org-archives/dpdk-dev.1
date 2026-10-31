Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9265606A31F
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Oct 2026 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrK/YT88
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09C04402E3;
	Sat, 31 Oct 2026 19:58:42 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mails.dpdk.org (Postfix) with ESMTPS id C15BA40279
 for <dev@dpdk.org>; Sat, 31 Oct 2026 19:58:40 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so19004585e9.3
 for <dev@dpdk.org>; Sat, 31 Oct 2026 11:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793473120; x=1794077920; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aKyI78D+uLT5WgFGR550c2XBL5aL8YklpeHC1DPBFgo=;
 b=XrK/YT88R1FZUvK4CKpdEMrnk1gFz0v0WjgEC3tveRwiI9dDe6QD2s0K6YEZRob7Lr
 vGxfdPhBkhHRuDss+xM4v9210B/EsKd0m/I5Fy3KmoeaRiv9hDrtm4ybwh1q3Xc4R37b
 1UHVbTxty5q6u8XgocdqflVHI6Z7equMsJX0RoO291kuCUP+9E1TQJ9YzwxYc1rwliWa
 nGCzqG91ceMTFe20Vd8df+FRG7I3ymqC8nRAHHdsAtkDVVAEZcvg8Wf4j0Xe7EGhvSa4
 f9JXPRtr/R7ZsYbIRWpSoe+0XF/L/n3mn8OV1V5qmpj5cPcrN0kxXnagow2fnC0VZ33e
 LSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793473120; x=1794077920;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aKyI78D+uLT5WgFGR550c2XBL5aL8YklpeHC1DPBFgo=;
 b=J5TNI/5jZZfM6MxKWoH8txl6nmAY66wufNYQjcBM35EZAVtsu0CR4mzTihz/p8RtME
 F79n3GpJm2wzb6R/CIgwggBW0Fk/JFz7ZBhxv2+MQHulQnSmT9wDkSN4X9/0mk2x1CcP
 5XobmZt5+eGs82j6p65eyHPwWvOKZbig/xqZH8sa4nL3Mcm59/b7oT6nZbZ6B9BbwKBc
 RMnLbvNHeTUuBwuFgnz6k2hpFIX2bPHpRb7DfCaVbmxLfUyqlcKT8IuvftOVDWe93CVz
 8oKRapWPG/FWIiJmCuEkYYkLm1P+4hXPOTBisipiIV9XMxh7s8GxKKRUSrNHG/0m4nGK
 yeUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwouZxJzghzQsnRR5oj34vBtPTtQUIleksH6jWJjUbZITOWcPX7AuoEr4pJp53pmaQ9YUA=@dpdk.org
X-Gm-Message-State: AFq9FYLPogdGpNpZBHUq9a2yxVKQBCX2j7lVinXBMDYUC73A1fQcunKn
 iZ/b/a00EXcz+H5nIN/wLA2Cs+2wrEXv4yP+u8gKxmRNO8AyoFKsOjfR
X-Gm-Gg: AYBFou1sTikhK1V3puoMSWWJJzQxTKKqXtOGvesG+0a2LzycxFPJQbAR5eESxjKsssL
 kqMsJWngbSgJsRJAmzgxxaP8V+JSp1GgvJQ1twAA02XqcCwjmZxYfeKBzmwb2kZK8LPBym+6Cs9
 Bc7aPycefv13SBYCQf7cXZx6+qhpq3X2wmUXjvZqyEe6d22PWLna+lc90RxfGZufmtp8DGiJUs2
 0F2ZIyY3BoEd/4cdhzHCZIzpJByLAdddh7BEs6DSdr4ZMCXydni7xmH3a2GYxIDzUxkM/c5j2Di
 KbcdnoLQHOIA3EEwChq2o0PhR4dPtk3mpp34kfX35w3uxeJKjlyhAjm1XeimuN+lRI0Xvq0wFtr
 Lt51JJI+4wwV4mu9NLw58cY7KHKZNl+nUvq4qE+LHmfW/m6nVZWU5jGXgyeXoNpQxoo97QPEp9R
 7JvKXUNT65iWzgB/CppMwXoYt/ympWX+DZsSn46lsoLW8PHvrUkExwCmrVdEOW4gNcvOnbyaJ1y
 voB9bPwOrJW5jRJfpYC69MpVHRpUpgABoSmH8pV/tnY1DvtxOj/26Eh1AlybBDqKtDQte3ib9hK
 EFG8fyooZCMl7528wHZP6rpB7Q==
X-Received: by 2002:a05:600c:3b0e:b0:4a7:7d22:c50c with SMTP id
 5b1f17b1804b1-4ac150b2243mr144528305e9.2.1793473119998; 
 Sat, 31 Oct 2026 11:58:39 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.55.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7246fsm10192700f8f.19.2026.10.31.11.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 11:58:38 -0700 (PDT)
Message-ID: <ab83280e-4e1d-41d7-8c26-5617bdb84a13@gmail.com>
Date: Sat, 31 Oct 2026 18:58:37 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix index register for classic BPF indirect loads
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ray Kinsella <mdr@ashroe.eu>, dev@dpdk.org
References: <20261027170619.2193021-1-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261027170619.2193021-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Converter code fix looks ok, is there any way to have a test?

BTW x86 JIT seems to still allow negative offsets in indirect mode (we 
only fixed it in ARM).

