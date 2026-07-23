Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE0FC531CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 18:11:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B00F94067C;
	Thu, 23 Jul 2026 20:11:57 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id BB35840280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 20:11:56 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so763351a91.3
 for <dev@dpdk.org>; Thu, 23 Jul 2026 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784830316;
 x=1785435116; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rgzke2Mxkz8RqgIsXhmqInDKZXqn4roQvjAfJMXoprc=;
 b=bzeDCjxyt1uCf/29NhVpdBDh/Dwx0GtcDsxM8fELbvh3DWddhl59FVfY7tQRgWW8dS
 x9YU6QVobZT2uZlDj2t1Obv3CtzuTsvJLtm/hOQ+fql/iyABaaaKtVDEMyLeLL5FNnHV
 HUQ7t9ndwfHgEai0/hbSeXnk8uy4m0NJKY1vj/EXojpKZhsI+BWQCcZU9yfJYNLf4uKU
 v6i6KVYflRHNqw4JWTUhlMQq6BV0MTjASR4ZP8ct5wNtgofg88OKnfUWLjAqFuJHqkII
 7Nzed1yQHQP7ruDXr9l9UURGRiIJ6RwH55NzqiXLJ3lqk7y5ej2JoEzJ+7GKg9fao17n
 e6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784830316; x=1785435116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rgzke2Mxkz8RqgIsXhmqInDKZXqn4roQvjAfJMXoprc=;
 b=lGkDhJZWqOe6qcuYojbDxNRyu4iVYPRttjhwnAx3d/jWMB//Iky5nU0d03RbvCLqzX
 zlymZNgRM+BvPsynq0R96p/wXCE9Ix3fBMyYunGipLUb37YFSgIkOz0rtbtHLgonEvOY
 MjjsePJ0qq+YpAPFiVJ8iUi7n8muqK5sRHIVNv9xo7R0ztIo6xU3QT54fLB0d6baSJWY
 qubeJK2IyxjCpamLMDnQqMYGYYZ2/QFVZ2H7P6aCzTFgAI1CkgP22r9GRcaS03VwBh/V
 L4z+sMIN3ImIGu926955AxdIupexCduvDK5JoZVlXH8e+Z9ziBZVc8krUsI2WilV6KsF
 qhvQ==
X-Gm-Message-State: AOJu0YyxsT+rebXtiANZhtG829cWNnzUWo5WCb5PrUVItujDWEICqCAR
 PSo9p2z9BqeCg1u4ZwEUczddW4Betwak2beUf66B4j2n2D/BfPEM5uhb/DwU8SaeXNngMI0T134
 4IyhH
X-Gm-Gg: AR+sD10zFeMIqwA7cOYmbwzjA/bud7TBKILSRHzOLXDjgy9OfWWri5HcNe657vekJ3i
 XJjqR8ajKUqpyZHYn5Wl2a7tKP9ABnIllaeO9oJwGTKHAD1sO4d+FTg8kqvVNThGHgVLUvdZHn1
 xu/YOCm9jqgZnLEM4yzx0voTgq5B7I/cvIZ7ZdqNypdfW/mgcFGWTDEm8uo/rA5TbyNjqr+2OFz
 FBe/nVH/7oeLqxftV/7On0PPgJ3H1qZHAmgceVZKKpds5nemvF8GjvvB71n9/RGbY9jOkpGkWWa
 lfBIL8uv/4UCUexBzMtn5ru4Gg96xvOZzx3WNIicu5IGN4Ftt3yZmBcWZObGhMZVQB6TOOqUrOS
 2/nNqiNfomUTdK3S9s2IAoUfGNbKJ86l62FmbEwDWGR662M4QZDFU/fzvhJYiYQtTQGgldFdMC0
 YRG6ohZ4R/AqbrfF3h9ncIED4uEK+n1Hdy19VmZyK+5FTnmwfTuoc=
X-Received: by 2002:a05:6a21:a89:b0:3b4:85db:1bed with SMTP id
 adf61e73a8af0-3c44b1ca844mr4713365637.45.1784830315823; 
 Thu, 23 Jul 2026 11:11:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm23791932eec.9.2026.07.23.11.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:11:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] drivers: remove use of /tmp
Date: Thu, 23 Jul 2026 11:10:26 -0700
Message-ID: <20260723181153.195915-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251231185803.90528-1-stephen@networkplumber.org>
References: <20251231185803.90528-1-stephen@networkplumber.org>
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

Putting Unix domain sockets in /tmp is not current best practice,
instead use eal_runtime_dir(). This also fixes use of multiple
instances of DPDK, and containers.

Stephen Hemminger (2):
  net/cnxk: move socket from /tmp to runtime dir
  net/nfp: move socket from /tmp to runtime dir

 drivers/net/cnxk/cnxk_eswitch.c  | 29 +++++++++++++++++++++++++----
 drivers/net/cnxk/cnxk_eswitch.h  |  3 ++-
 drivers/net/cnxk/cnxk_rep_msg.c  | 26 ++++++++++++--------------
 drivers/net/nfp/nfp_cpp_bridge.c | 24 +++++++++++++-----------
 4 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.53.0

