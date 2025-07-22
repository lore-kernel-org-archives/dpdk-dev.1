Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26DC83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 03:49:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF15D402CC;
	Tue, 22 Jul 2025 05:49:37 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id B1044402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:49:36 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7e29d5f7672so461772385a.3
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753156176;
 x=1753760976; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avAgBQqv5jCWY6yJs9AsR23vPkVhUXAMHV6188sJWUg=;
 b=uo32Ty5u9Sps6ydZ7VB3oHvQmeG65ixStDgiBmZOY/FnGSwixRcNXU8wWuT3r1UL/9
 hS9krNA9SGXvf/66YoQSH99GL5Bg92zTQIYUG+XGZBmWUm9/M15xV4nJcpcxp89a7aqM
 /OmH5+UZStO7BZZj3ZDsEH/A/Hlb+Mri5MY/hjtNiI6qREGeC67gfphATFaHtVA5WhSo
 r85SQd03YjfD7qwWbU7LMaKqql4b3dhpDe+84k+32A21juY/9aDyxCeAmtosBuF4mwDc
 pyrFQAkYr7EPC45GQEi/oyg5aEV2hWzwMWiQtZNBLIMWWzZDAo7ybW1KGQ/KwX8stVkr
 QtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753156176; x=1753760976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avAgBQqv5jCWY6yJs9AsR23vPkVhUXAMHV6188sJWUg=;
 b=wqX7GusGrJKCscwtFqQ6FlfhFqAH7JQIHu8OFosdoHS1zJm5YRRWjEcjLZ0SHrxCSf
 TD13JnGYswBqYUN5qwmJLJDn42v9TxZjVjUFFZJJhxWdz/3vXudQD9b3QvIMKBV25LcE
 GggHpzIIxwNjNQtq75RbTFD7T6InzkiJ++Qjf6jgbpaFhz0Q1i+94zK1ldqB+QoGSfQe
 tOEs/haOwBrJ1jNwMtBNo/oYN0mRNwR1b8nhEZ6eKEbyd7JTumYtaMfca89MwzAhAkWr
 xXQSZH0AM5CAhkGz3LqOmUiqeetyAH8njcKjJelQDV8OUw5bmm8Z/Q1ZG15kcFR1pqRt
 LzFA==
X-Gm-Message-State: AOJu0YzXqn8htqG2vLbb1QmpvO0ZTBEmx4jsKILfO1AIBs47UTjH9TFW
 uKGBwP+hate4+dMXKuRT3MNRL8PadFgOFQ4QDtrCxJfxTXLDXzThzOXm4gBAW3DoD4Q=
X-Gm-Gg: ASbGncv0JGsI3K1tWE5JUfM0PGKD8ymCiWBIy+A3qd5fQnOSOeW3XysfevNAn181k1D
 ksIcHqsEH+p/SABGFB29bucjGm8EqvBJIfd3KfXPqb6rNqi9r2coMAMTy1ByIfF7p32qiPS6nkp
 I1pC1qHv4vFvpnmn+9kPkWL6M+gweccGzkDyUTQ399ZhIfUjpI8tESIxo8aPpFnmzXG8hNPHRao
 M4Nsz0BOwDwriHncqV2bJfFn6krkWM0a2ODy1tVOIOJexNLVCA1oUiEbN0ZjoJews6iJdFupnMs
 NbWXjBI/ec9DN2EQXKnfRpEKC4Lb/CAdYrBeE3w1PIbrIWYmfgJPtuHIowZ1ULSsLhIDwwVIdIE
 p/GT9PeK469b98iZYuHg8GCx/i9y4iVr93296YcKUkRISekkcBcb12V9k0NRQRM2GpiCQZtPEQN
 g=
X-Google-Smtp-Source: AGHT+IFNzg+bNkK+EBrkrUdJawjRJeU1fu3TUnDWb44dis1Cno+I+BSuaFr7QyWaMEeWur4z1mmmLg==
X-Received: by 2002:ad4:5aee:0:b0:704:7df6:44b4 with SMTP id
 6a1803df08f44-704f4a85228mr434880026d6.23.1753156175954; 
 Mon, 21 Jul 2025 20:49:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051b4f9c14sm48406806d6.0.2025.07.21.20.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 20:49:35 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:49:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] app/testpmd: fix set cores list string size
Message-ID: <20250721204932.3c7fc3ed@hermes.local>
In-Reply-To: <20250708125159.2457578-1-huangdengdui@huawei.com>
References: <20250708125159.2457578-1-huangdengdui@huawei.com>
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

On Tue, 8 Jul 2025 20:51:59 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> The cmdline_fixed_string_t has a length of only 128, which will
> become insufficient when there are many cores, so it should be
> replaced with a cmdline_multi_string_t of larger capacity.
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
Queued to next-net for 25.11
