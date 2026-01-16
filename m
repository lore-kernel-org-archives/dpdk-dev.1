Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B76DC982DB
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:22:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A87D042E71;
	Fri, 16 Jan 2026 18:22:47 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 5BAF54026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:22:46 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so14352775e9.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768584166;
 x=1769188966; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOHZpfPQyAOBySCQeYWOE5MLJosYkD7byzzHxMHzlhU=;
 b=pLv9dRpdOwM9ih7DFNzYGYsUsy9cTLsbehNnOoJZo8gq++TIp5M76i3ndsmJ4i8n0Z
 35cwS2KQkhYmGRuHes72gqTe5nR9AuYuEkhpfKclad90jkx1pKSmV9T8jq36zXQVtrvE
 tGspUHI5LxQHy5dqmeeXPi7aIArPbFt1XE67elvC5wEYT5bTRKG3ZnsiAl+d1irS/eU9
 lKfuZlpHPikTGiRW+NJHuYd+isQ1JOhGrwSnKlD5Cy4Kb8yq2KvPpWm/KQ7fpdn49Tvu
 LVHSXmydpG6zTBujM1EK7+AkO0AaH4agQPiwa19a7XwFbIFWuvRVBVp8kMXsxosTiFAn
 fBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768584166; x=1769188966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iOHZpfPQyAOBySCQeYWOE5MLJosYkD7byzzHxMHzlhU=;
 b=dOsK4YJHqGWu45L0XrcdRFN67ns+Ihq6JGNpS0Gh6a7V7XKUaTJXNGiMT0rxI6/giz
 OGBC6S6O7Qm2Jr2+dSx30tCxL8ylPrDNIeYIte7nk+ru9tC/XoC1amVIWl70uJ9tKBEo
 sFPA5rkwlp58b8zR1Dmb1Jal4J9VUpCUef1Vf8AjHdThFngEclW7ZDTT51cy6zJsYiZE
 U/ecBz9N7xEHfPrr2WyPJWthVtbvlsiQdSI/rLFzaJ7U6n9eY2y1bnynQi5ubqsXlIPy
 nQpIkGLWqIB0BZZ3DiRZwZ8m+iNyn/Kez+RlGc6qOfhs/JK/idNAwk3TNyYyeK+Ov9pj
 slFQ==
X-Gm-Message-State: AOJu0YzuJ88SWiJYNMIuj5uBwJTpKG/ND5E6tE1wHcuqOm3GTTocXzc5
 Po43L/hs8Rez09mYbPMOsow4krKWbSec4nw3jxILQvtfK9mQ3X9hP0n8GkFD2L7yqGY=
X-Gm-Gg: AY/fxX6zKwMlFoKppLcJcXRThODwvVsnTOimVp1Qqgzc+gq+mAoRtV0CCBxQTZ1svfv
 Ol36mQf+WjNoAPSMo27cITC09uw1cylo0U2pcfqp2gAupmQ7FKHXwSLKlSnnZBbHp7mt5pPFjvI
 nZfEjrGrbC82XAr03RRQi6r9IojBXVXWmxzXXYZ/xXRMMuV6/HUFt46pCmFVhC94rb/obUkJgOO
 uCNBCi4OxOkf7pZl/i8R8sdyz6R+Ymj3i/SuBKxw3stjhyP7bLKI+mUbYVTChxbb1zcpGO1vKgr
 EscQN5nUKK7qdrPUagBeVt7Bz9xd5WjazcQDCmeC9mS0ix8V4ZSGct47j6QSnud8AoPQs4Y8BXM
 uLqlTvO+mASZ3NPAP/XTMLdN1Bzf9HMovBdrssJKcKafeRnDl0Po99nR1DVfFxamIbXBpEuSZyO
 LFlFqlT8OslHK/JKESkJWEORA5QNeSh0lroWDqMLbhmZTBL4p5z8wY
X-Received: by 2002:a05:600c:4ec7:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-4801e30dc6fmr48591885e9.13.1768584165976; 
 Fri, 16 Jan 2026 09:22:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fd3bcd2sm23573325e9.1.2026.01.16.09.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:22:45 -0800 (PST)
Date: Fri, 16 Jan 2026 09:22:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 4/7] examples/flow_parsing: add flow parser demo
Message-ID: <20260116092241.609f0aa6@phoenix.local>
In-Reply-To: <7f3003af12d870193be2cfbdcaea5873c8f72e6b.1768518003.git.sismis@dyna-nic.com>
References: <cover.1768518003.git.sismis@dyna-nic.com>
 <7f3003af12d870193be2cfbdcaea5873c8f72e6b.1768518003.git.sismis@dyna-nic.com>
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

On Fri, 16 Jan 2026 00:01:10 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> +/* Helper to print a MAC address */
> +static void
> +print_mac(const char *label, const uint8_t *mac)
> +{
> +	printf("    %s: %02x:%02x:%02x:%02x:%02x:%02x\n", label,
> +	       mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
> +}

Prefer use of rte_ether_format_addr
