Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1562AC87FC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 05:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D11F240668;
	Wed, 30 Jul 2025 07:07:18 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1B08A4025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 07:07:17 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so6858249b3a.3
 for <dev@dpdk.org>; Tue, 29 Jul 2025 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753852036;
 x=1754456836; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOVLq4LIkeQwRFOTJyk5/7dxT4AVmK7qMvefoffPBFs=;
 b=CyCotyqfPqiKJ7RgjktOtrfGlso7wVGUN67I+d2SuW9Br6dJq3dHpcmmAOijhZUco2
 zAC/BeZd27pN7BxkEpDyoeHlcXPB7A/A213GsxQBt9S50j6eniQy/83eWY6GrWlFpgZ6
 1RhOOXwn0ixAihUjmCWIqBfTS0SZhvOVcc7jwmjjDyE2IlxYkIGhBUPl7Zc6duHZqIme
 gYNJRIbI7YZlEnX17jBIAG6HbDrB4rWt0B6cmh4yzSKESNDAnMnnqDM6bgIzqS4esukG
 SEokusb6IMo3EozjOVX25cHAu0mCZW66uvXTnYEFUS5sck678addgW4yIMPhz/V+7827
 ovIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753852036; x=1754456836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOVLq4LIkeQwRFOTJyk5/7dxT4AVmK7qMvefoffPBFs=;
 b=ZNn4+JsMnUykBUbeyMWNnYHqZMk4hS5XGmPyj4D1sAIkpq+jiQ0aXHk/HcY9lKlchc
 CVLdoOfmUy83XuZXC9FCvv+HqRsUQ4JDfI4oJKqkyMMEZFDrfRZmqcz+vMlou570H/1v
 t9BGk5Yds9batrGkMpBPxyOkyqAuIKSNB16gtCPghAOtdCatgYGXj2SLwGpf6zOtdR03
 1HjRIL4wKFOX2FBahiMQwfzD1ayAmJKbajZGZRChJsz3UlOuaNmighknMOht4lqKw6CG
 T/sJXPsqIXM6s5ZVzYVFnLu2L6OALV8fxPw7/jf5XLM/oxdWIW+JX6YKw9d72bXSE1Bb
 XCQw==
X-Gm-Message-State: AOJu0Yzsf8eukDuc1lsPS5U3m9m+gC8IZNe/4IhAkXJYtV0guAyglNwU
 UpZelNFaaFKzLe55wr3VfsRJg0HLeataXOcfiS7eQwBjND4dHDIg/4vuHB0QOfwuZQ4=
X-Gm-Gg: ASbGncuMp5MDO6LrqVTSQuhGjOKp3+NnQKtLneKnpQ1o+0Rzua8qrQlds9AuBRMPPhS
 DuFm9t9Zdd9bQAtL6iignmZo+qqUG5b5aQdwE2+SagX97FSCxTHbpEHj6oHgvHem/XyQGnID3Rn
 ycfd3IZ9bTH22oF8D1gBLbXSAy2Ttk7PcI+n8l9lQZonMidLyim89ZcfULR0oeXxQ67aA+NKfkX
 /UMknH892WQpSFmtQ/VqKv7eG8sd0nMvCEQYsTjc3kWbGC7a8XkwIlHn+aNkZhZ1SgF0p9074TN
 6Gw0ouOLAk4dL9BN4e+8rVHNiWV1PIp8KmkPbumHZezZO3lvlrFlF7IHI3yhvwJCyE0ATrtGW6J
 LpUpU74rSu0ENde+JAJHcI7RvREz7qimKag25QcopB2rpuk/S
X-Google-Smtp-Source: AGHT+IGr9xs4kNDiUXJYLSFSKi2aZzD5C0l2ANoUZNrqajOWC1HHeLtgu+4NfX2i28c+Mk8pqmgYiw==
X-Received: by 2002:a05:6a00:844:b0:75f:7a4d:ea11 with SMTP id
 d2e1a72fcca58-76ab2946b13mr2680323b3a.11.1753852036076; 
 Tue, 29 Jul 2025 22:07:16 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b3d3d3csm9515124b3a.111.2025.07.29.22.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 22:07:15 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org,
	stable@dpdk.org
Subject: Re: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary process
 by validating dev_private pointer
Date: Wed, 30 Jul 2025 01:07:02 -0400
Message-ID: <20250730050702.74381-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729143420.0fd7b627@hermes.local>
References: <20250729143420.0fd7b627@hermes.local>
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

Hi Stephen,

Many thanks for diving deeper into the issue and sharing the insights.

I agree. given that the primary tears down all the devices on exit, the secondary is left with dangling pointers and inconsistent state. Without a mechanism to notify or synchronize that teardown, I think it is the only option for the secondary to exit immediately, without attempting any cleanups, once it detects the primary has exited.


Best regards,
Khadem
