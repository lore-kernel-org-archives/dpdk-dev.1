Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2CCC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 00:57:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CD4840264;
	Wed,  8 Jul 2026 02:57:02 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 843AC40041
 for <dev@dpdk.org>; Wed,  8 Jul 2026 02:57:01 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so65152f8f.1
 for <dev@dpdk.org>; Tue, 07 Jul 2026 17:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783472221; cv=none;
 d=google.com; s=arc-20260327;
 b=n/2k0nGyZxk3m8ALK4csYdT4JCYnDYZ5ypmdiK0mHiK4fE4tRyaYYsVCxLGyCB8G2F
 ouLhO5LOEw5vL/EeVyCo2jYhY7mG7RUPzNU8kh3OXmsincO6ZiWB3vXYP0YqFDjg5iYw
 3evATa/1CgIZQhlLMVxwuGZt2rCeAs59Qf1iZgLNhbt7P7IxF1KC2/uTTllLxaPvzCc1
 9Y3WOR9WEY4eJcaJY0URxH8O8B4NhggIanSRcPdyL/hmiTryXKxw+N04VzYLtv6vgyc1
 8uJDoSX7CiUX/W66JPAhlunGBxoIQ1Z85FNacQY+FWdZVvPUMheAv/mB0lqFDGq0TSTC
 y4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sswyHjBruv72hF8v0UWc3PgJw8bzCl7fGltxZ1TxE0A=;
 fh=o00qSjHKxQ9JGP+vRASrglzRCDqfT73fO6pwN4+RnOQ=;
 b=SXp5xXRA65kfVhOCRYH3Vojq98TvafLNJpkiPy3ou9+ul7saAuKxFCxkzrOSOAWfSv
 30+aTR8nJXKl9VYMAlA5/1Zrtv0f0J/Bg+3dd8HWSM/CdP0OLN64xMM9HwBLWZJA4IrF
 wyXhTw/5rVg/SO9ynAeFw9IA2lxkVj7r0wQHtlqZD570i1GHaEwmEEoWbKIDaVrV82ov
 v+Xaf+4CHeLLIeV6zjcYd+Hzz/h7Kle7zxHCsSY6lbLmf4X3PKYRHtvCXtz7JRVtb+TB
 MRS/GhGK+MDuL2JatEbI0zlq0tXvyNZDkcY+ap1Ec0v2XLbUthWtdV85/mjR5HYOBfH8
 bHqA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783472221; x=1784077021; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sswyHjBruv72hF8v0UWc3PgJw8bzCl7fGltxZ1TxE0A=;
 b=dtltpqn098dljl4Jgo2kIA6f3f+9sEUAcRecr2NeLWCEZbG0KuFLjaH+EPc+0YBlun
 BeO9p9o53e345K7IaFgCbxBkSilN4WprfBYy6KHCazqFZzyx+yTpC0P23ncMZD87Qn7x
 r0Yr5Perwz1X4zdBrvmfwtsIso8OjS2H3u3oUow6WdlTxfmmJvViOpA3FGtnzfYbgWvT
 pgtkhVih2Pqshl8S29oiSLzCUKn5bqwg4A5PKSKMNv06PgPU1VJ4/rotIeLqjMVr3ksR
 eABG1U7l9Z2F0ynC3CDbPUWHGkRp4XLD1XDhTrh+ev1YN1AkZ408vIxHYjR16y2QoTqC
 /MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783472221; x=1784077021;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sswyHjBruv72hF8v0UWc3PgJw8bzCl7fGltxZ1TxE0A=;
 b=NQn6XY+eGtfjyB2TMXXFKE8bsPI1VzSyIGyG9NwSCL0rWNRnVdwob8wHeng6KY/mVl
 8/ZzZiNx7oLxzxvp0/xbT+vYdvQEKWMqHY7LrcvCKKJLg+VKE8vkF2KXltX07hrRIEgq
 Xa005vyCc/losvPrd3QaY8RxAqCK7YQi7oahvvjpEp0V7PCgTTI8BCht7rNVh0lZidIk
 ii8E+y+94OaoTHyfaXqA1+2ogfPRXKRNAklf13S8VtR7S8Wq2aR1jF++YX/A7jIin9LE
 4xeUDrXQG7RKVliQttGuxy4u2IprCjWdPxnZmbxTFbQlX7C3tbaDnHIcNjEEC8CUWg0x
 pXtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpBUvFQs7iuooTTIELDjwTP34Y/yuDf0SWimx2O05KhjudPzTYBNViPdk00nCkG7nDtF4=@dpdk.org
X-Gm-Message-State: AOJu0YxiaNjdz7Unu5+SNTe40K8tK5chtOD/JVoHqOLqDj6FPIZRf1VE
 rDF8Udglh0BjN5WXmfwuw3dlRfcbjl8zG1UD7pUTTGVDZU94HVbNJHKj5E6mH+Cg5DrvScfAqmI
 1UckRkaC+qwZFL2h1GFHpB2B/LgsIrzc=
X-Gm-Gg: AfdE7ckfX9HQyeak/XVt+mc4ZjHfBwpFwrZakUWmQWRKdyEbxabo39Nb6+Py2N69UW3
 ulp+nXVNWnubTW/BvllDISWQ53XT44Jiz+KvvkCR9YfkDvS48zEPA1rMBM9T/1FID4rTmPcs7ua
 wLqHrnDG8FRVCVy/jp2G84LQDHSCerpIdZ5k/xSXEyAkr+T2qL+RLCFzKAg6eFp5GFBiwyYWIps
 b83iXEr9hTcSfNyThlkU70gZ9oZ22JnJA3cIDilG6z7ojZLhYLPUJpmldd5HZ9QxAzdVaJnryra
 VsQhGR3kQcPrZHwjoySo6m69xn9sR4vA+Rndu9MqA1wkhdiEE1ytnz3k
X-Received: by 2002:a5d:5e8b:0:b0:473:975c:4fd1 with SMTP id
 ffacd0b85a97d-47df07bd862mr35886f8f.25.1783472221109; Tue, 07 Jul 2026
 17:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260428181501.72434-1-abailey@iol.unh.edu>
 <20260706132633.465385-1-abailey@iol.unh.edu>
 <20260706132633.465385-2-abailey@iol.unh.edu>
In-Reply-To: <20260706132633.465385-2-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 7 Jul 2026 20:56:50 -0400
X-Gm-Features: AVVi8Cda8HTJLGjaDx1z3uXoYtIZoVHc06mlhzbBwBwrNPyKKJJO85eC_I_odLU
Message-ID: <CAK6DuxvnVYgauVfO4OU0dehdnkPdWQEE6hFt+Sq9kuyed91-zA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add latency coverage for cryptodev testing
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000034c2a606560efcd4"
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

--00000000000034c2a606560efcd4
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks Andrew.

--00000000000034c2a606560efcd4
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks Andrew.</div>

--00000000000034c2a606560efcd4--
