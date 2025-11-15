Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1FDCEBF7E
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D35D640B95;
	Sat, 15 Nov 2025 20:34:14 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 34BD8402A2
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:34:14 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-343806688c5so2953142a91.0
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235253;
 x=1763840053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hYEf6JUgGHhgBy5lJJfPpcmheYhaNDgrdknhW6pWIes=;
 b=WzA+3eESZLNbSeBXx4nlbWs0dHgGsYe5KSaFUfBlRJnAYiY9/3XfoyZZQjR00LmA25
 ut2T28kzpx60j9/LSZPSnUP8GYUPvugULWtJUJh0kYtQ+uEiqa2zfGfmM8yIH2MgQHfh
 co5FLAzUehe7Rcl9J0yuxdEnu8OYEtOe8r6+w8ZMZcClJSxDl7thtihWp5YF2EKFWuqg
 qcxSsrAX7hAlPM8ySxeIMKh/h8YBP0btDJr78jcjKVk6J9RN5hdCWp0YnZeWbwHLtyGF
 BUyMn+Gq4q7x0wHpJM4toMaPS2teywlqTKKMMEZZrJIXkMlByf91ghAKBjANCxHQg8kG
 8aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235253; x=1763840053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYEf6JUgGHhgBy5lJJfPpcmheYhaNDgrdknhW6pWIes=;
 b=SPSYQf9SwRGhKj6Hj46bR+PMZFfXnIcv3BHhw8ZZ/LNv5JEJ1rI5WSYG3F8Kl4qcs/
 jJXB5Ewz3MbyxxukcBlkPlphEkcJhodvTBcmSLAs7txwJU5C94ag+Mv/icNzMRPmWffs
 hX9FCr8MHwlD/5kwIbOQ/X60VxEfhZwyAi11NM71yIPmeteCiOuYtaJHHSlGeTNM4V/B
 EQ5s//NaI+A9yqPVw/4fvrBNn+wGYCq24KExeVWg8Q2nQnJ4kNU2Pv71eJWvLfWjccTM
 FpprUCGj5fUxuzZ+mOSw1d5f0TicIOpr79ahpsq4fFQnF5dtnZDJ0MagIfLg7hdjyMvw
 XGPg==
X-Gm-Message-State: AOJu0Yxl1/ErcbV1w4Va8+sFxUWcHIiIWGTqdp6bwCVIigDAsmm/BYft
 iw+Wr2MA9kq7QHFkhiL+bR3J2VPEKTgNGD6M72fTAAP/HPYPRv+Uf6ADjJD0PKVf7Y580yuRdHh
 81vU9
X-Gm-Gg: ASbGncuNvsalFLkJQ6j53z2dlQmUqR671NKQrbkGg5eXRHt+D4kHivyGAkn8H0d5wa0
 8ZcNAJJuAjheTVV4EvYd0/f2fKSNFEcduPR++vq4r2LFxEEzV+3rYZYBDT6LIOCK70j43XVQakb
 YEa/s82tP0h6GFITX2+ebMR+hzvPY/ows1cQP1tpJ5p5iRsroSF/DFRiSBfp9BcP4FHzJ1VvEtu
 2eA/NgVf/FTMTq31iEryrIkDpFnwiDXWCWogjXdjebhcYIevco5kiGe7Cns4SyFdYyu4xhsNLM1
 XG3O2PhyrPoNItVOHFjxyXENOnbqsQiUv1Kg3miS3GiiDi++G/XnCnsb4Gqu0rrxISdZ/JzHLD4
 9Lnr820gopnaE090UD3TAxPfrajheEnfEB1EO8vkGjfUD93a063Dig4Qw+3QN/jPkvHerjebsLD
 xX3uXSo+vZXlIvZafM0COXATDXKlyhafsN+3HgiYqmc/KSvc7ApA==
X-Google-Smtp-Source: AGHT+IHcULhVCkJPLBXlbZ0fmTd8GGuFJziqBr+3a1N1ZFYnmLnaqdHp+oz4VAnQy6GUP3FYfjBIqQ==
X-Received: by 2002:a05:7022:7e07:b0:11b:9e5e:1a66 with SMTP id
 a92af1059eb24-11b9e5e1b14mr862485c88.14.1763235252902; 
 Sat, 15 Nov 2025 11:34:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088604sm26588644c88.7.2025.11.15.11.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:34:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] test: eal flags cleanup
Date: Sat, 15 Nov 2025 11:33:06 -0800
Message-ID: <20251115193409.99740-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Revisions to the EAL flags tests to cleanup and fix warnings.
Split off from earlier patch series.

Stephen Hemminger (4):
  test: re-enable format-truncation warnings
  test: increase size of memzone name
  test: refactor file prefix arg handling
  test: use unit test runner for eal flags

 app/test/meson.build      |   1 -
 app/test/test_eal_flags.c | 161 ++++++++++++++++----------------------
 app/test/test_memzone.c   |   2 +-
 3 files changed, 67 insertions(+), 97 deletions(-)

-- 
2.51.0

