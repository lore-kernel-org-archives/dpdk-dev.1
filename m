Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69583CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 03:02:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02B0A402AD;
	Sun, 18 Oct 2026 05:02:54 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id C1401402AD
 for <dev@dpdk.org>; Sun, 18 Oct 2026 05:02:52 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3514b90bb89so2775226eec.1
 for <dev@dpdk.org>; Sat, 17 Oct 2026 20:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goodkind.io; s=google; t=1792292571; x=1792897371; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bw9vyIHrPvlhXQ9973jle6MISlA8TQg6fSLHkmLnJ4w=;
 b=FlD9bUl/a3L5mBbLX9NGhdyLupdSJk+91Tva/zIRoo7cKsioqQlfSJcTDb1kDNxVDU
 h8DkS7rfibz0emuMFDs9l8N6ddE8w59Ftuv89wWy8gKKj9KoAjmHOzAU6I8jkX3K1mb8
 to+9gYOUqDrooPDQrr4F688CIlgMd1ujpNaRiY8oTQhMm+p/ioT2kV4JT9uKvOE9NC11
 /u9MvVs99hU2SBOUsWq6CFvaSs9EEksBt1shtd8euuKLucx81tfcCwqK6QXV4McrxTtm
 l8f2MSTWR48blDeHAYQwMruTCszGu1IMy8xWXqC3mR5gA/G4lYNVQYUPXYsz6wqCUnT5
 OEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792292571; x=1792897371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bw9vyIHrPvlhXQ9973jle6MISlA8TQg6fSLHkmLnJ4w=;
 b=QaibDShvQvOeHnJsx6cXmH4J44LCa1zzpA0v+8z0Tj3tb2PGGSvDJQpQdHXKPa9Ulb
 p6VUdIH1XQTLt6N0W+fnyuTDj4f5/jCfZJJJ1M0Z5ic4MiZl6iE4wqkSqcArV0hvnHXz
 j/cVx5oFZoLib1WATPubWQ3uh40KbrNCHDsf7OPu1mwVxs4/HCtFn6BmxAN/v7Q4RTwp
 CjiFl3S8aRyOlUTUd5nRH6DiEqPFV/pK+ghgm6fja11yZ72URN5RkgIrHgEnnvnHdFj5
 ZU9IvWd+RyFC5bRD3lkzhLdrwoOMIJAwDG6HSCa8LlxLW0mZ9fDsOZCoCzdIDZer7ola
 CseQ==
X-Gm-Message-State: AFq9FYJe19W/0/7tw5TF2jjKPqPHJB8J7vP9ulEw4ATXVDBbaMtHyJMS
 pELvFdGMA2VbNakCk02HQIsrsUgAyblxhfCipI0bXBru1TDmLmjaUsKaxGUjYtudNMM=
X-Gm-Gg: AYBFou1dK01t+0ZVQVr9uSkXmMx2U5hTpSGV7ZR+bSPtICLgEvBFZUUJmTBXMFq2ICm
 w3E6cUGpcsXrT1ZnNGzTjb3BthwPjx7CL4HCDHNutc4LcGBkZgKDrih/PpQiLLvN6pJ3lKdZ59p
 xX8l1WqEeXpps0cPaia+F//FcTmc5HCOgHDeRRDNzcW52EiZ69t2CUj+JcPHMHQirb5eWuqC4/W
 R/hXHIYaiBf6Wrkt4d9wI5ebdGoF2qTwmesUJNAvBhPRvDBGycy2IsfoHFiJHlTjNzYN+iqA0om
 r9U5fOhges2+bm7xNQRRU+qO1zJo+TQeJZr/hrJtg6qnJlVkUM+rQp3PHjZkVQn1+wRlbOvgSV6
 LmJHzMEo/33sQ545frSf7wENTW+eGlnIBlSauBpZ/WKuJ07GK6GF79KZ3izW1OhntpLi6Nzd0hx
 BRNDGmvv0TdNkei9e2h2ENjznN2x1sk4g3wVYmGoowPaja8yLmE3nHfQN5Zzi1bZwl4n7XIPwWx
 6UTpGq+XM/oIiRNjQP+b/KzxA==
X-Received: by 2002:a05:701b:4306:10b0:187:ec67:2fc5 with SMTP id
 a92af1059eb24-187ec6730e2mr1708508c88.32.1792292571472; 
 Sat, 17 Oct 2026 20:02:51 -0700 (PDT)
Received: from localhost ([2001:5a8:4296:4f00:a1c6:b570:cfa:f332])
 by smtp.gmail.com with UTF8SMTPSA id
 a92af1059eb24-1831c5cb39esm19217866c88.22.2026.10.17.20.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2026 20:02:51 -0700 (PDT)
From: Alexander Goodkind <alex@goodkind.io>
To: dpdklab@iol.unh.edu, kishore.padmanabha@broadcom.com,
 ajit.khaparde@broadcom.com
Cc: dev@dpdk.org, test-report@dpdk.org, stable@dpdk.org, thomas@monjalon.net,
 tarick@bedeir.com
Subject: Re: |WARNING| [v2] net/bnxt: fix aliasing in firmware command writes
Date: Sat, 17 Oct 2026 20:02:49 -0700
Message-ID: <20261018030249.80449-1-alex@goodkind.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018024910.5D1706051830@postal.iol.unh.edu>
References: <CAAbO5hbOnKdeD78Q6BHLSA-dD9Vzo004Myr_74_yK4as=bb6UA@mail.gmail.com>
 <20261018022929.91865-1-alex@goodkind.io>
 <20261018024910.5D1706051830@postal.iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> On the last iteration when i + 4 > msg_len, only msg_len - i bytes
> are copied.

The copy length is sizeof(request_word), so memcpy initializes the
entire uint32_t before rte_write32(). It does not shorten the copy
based on msg_len. The previous pointer dereference also read a full
uint32_t.

> Missing release notes update

Comparable fixes, including the enic aliasing fix [1] and the checksum
memcpy fix [2], did not include release-note entries. I followed that
precedent here, but I can add a release-note entry if the maintainers
would prefer one.

[1] https://github.com/DPDK/dpdk/commit/7895d17cf41094cb7d5ad67f484dd492f5a643bf
[2] https://github.com/DPDK/dpdk/commit/1c9a7fba5c90e0422b517404499ed106f647bcff
