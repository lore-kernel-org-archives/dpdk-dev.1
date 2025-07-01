Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C99C83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9757D402A5;
	Tue,  1 Jul 2025 15:46:27 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4D32A40264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:46:26 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7d20451c016so191688285a.1
 for <dev@dpdk.org>; Tue, 01 Jul 2025 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751377585;
 x=1751982385; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hyMBl7uxurNtUc0tIU4t/8vMkayVaP5w6WhxaHP/18=;
 b=RrunXywwWj49wHHctQ8U9pd5HjErpIq/IDs46lhaGTeUiJsk26BJZZwcikOIJ6LMVn
 ehxcvMJzofXW5h7sRRZ/yodHOxul7WDliPTLf2vdF4v8UR20OUD2cJYyZEsz2gwMhXxU
 5TV56kiEJmSNHa8YzL6ha/xL6gtnd+0RXktIvz9jma3V94AMuyTrh/yCHn58+4SOgps0
 9rRVppu96IzZ/7FJ09a710W9XXYQdsdPGMsx9bGiag049wgWlPTJ1nOVu3A9/cX+NQHw
 TWcbPLg1uKIozjbW00hawlx1U9rFXvzpyV+p7PfoxZYWNbpQZvkPxt2h6v3kv6c8W4p4
 4WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377585; x=1751982385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hyMBl7uxurNtUc0tIU4t/8vMkayVaP5w6WhxaHP/18=;
 b=krvNbRkZ5ggntutCm4Qxqv/HY8LAdRPlS1M57b/fh5rv+TTPKgjkHuURw9lxSsyAu7
 5AS0ZOdfwwqqoRFjv5QZLHrLVkpkS/lOYU+rNMZIOc3reIM1QxCBAFM4mqfZ2LIqUwgU
 rGIHdQ99VMKed5MagAZHDl7ewZE3r4w7JurmmPoIG3cOhxhF1jZvacEZdwZE3XUed/Qr
 +GL/KkLhwe17a8FDkwYS/HFOBuZK09s/UNDJhhi85yBplLXPbjwnQxqJwL7+xiMm5u0M
 5KgOSqXRZ2QSWlLwe8pgegXKgvSdFLrNeAYwcG6iBD5LoOyQFvTE+eU/se8Q+yx9/M4p
 elJQ==
X-Gm-Message-State: AOJu0YwwAfW7OvNgfjd5Mtg/A7/JofNW55/0OdCtw50ytQwjkvQQfXVn
 eJev/e8DPK/4wLr27Yzizy2FVKwrFw7DRo0Lyob9AIJK0Q2CCxczAlv8dI8q6pvIrDu/Aw+MfHb
 ek0Rxwdo=
X-Gm-Gg: ASbGncuAfcP+5llS1ybvFtbZ3tpNriSIZhcBSY+ohYD/+RKLJ5Jkqfuu/lwP+BhMTVd
 9KQN4m0Ef35S63vDHtg8xgRH467RQ26oh3Ww1kYJ5i4heUDJcirzhMiaRamNByP9ViTWq+i0NFe
 sVzbcvkh7ebXPsBLfHz8GrtkF/wDSO7/+MCENYeChrrO/RCkTlcwJETD/JrwXaiiKiFvVSJgg/0
 Gynj4dOYpsyZXiZeebouWqXmfQ9Zf2UjvuzBSS1LpzZNmTRzrwxmcIeXX4JZMopXUrXwZpkUm4l
 EEZvjx9Ge034DECn9/xuw4lGus3DXm9HeX3E3bLDJGwo4wG9R0lNdbX+4joflMXBflM7d41YZkH
 iJgPk+8FQd20A751gW2Y7uqTrpBMBG1zPJD5ORo0=
X-Google-Smtp-Source: AGHT+IHGygF6sxNC3KxZeVThcnOubhmdLTd6fOlKT/wq22n11c817mSbWD7K1REEEPkDgGzbuS5E3g==
X-Received: by 2002:a05:620a:2b99:b0:7d4:5802:6b52 with SMTP id
 af79cd13be357-7d458027033mr1167521985a.33.1751377585494; 
 Tue, 01 Jul 2025 06:46:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44320563asm768921185a.55.2025.07.01.06.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:46:25 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:46:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Vinod
 Pullabhatla <vinod.pullabhatla@nxp.com>
Subject: Re: [v5 6/9] net/dpaa: add Tx rate limiting DPAA PMD API
Message-ID: <20250701064622.59a8c75a@hermes.local>
In-Reply-To: <20250701113707.2793004-7-vanshika.shukla@nxp.com>
References: <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-1-vanshika.shukla@nxp.com>
 <20250701113707.2793004-7-vanshika.shukla@nxp.com>
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

On Tue,  1 Jul 2025 17:07:04 +0530
vanshika.shukla@nxp.com wrote:

> +/**
> + * Set TX rate limit
> + *
> + * @param port_id
> + *    The port identifier of the Ethernet device.
> + * @param burst
> + *    Max burst size(KBytes) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @param rate
> + *    Max rate(Kb/sec) of the Ethernet device.
> + *    0 - Disable TX rate limit.
> + * @return
> + *    0 - if successful.
> + *    <0 - if failed, with proper error code.
> + */
> +int
> +rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
> +				 uint32_t rate);

New API's should be marked experimental
