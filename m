Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8FFCD98F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 21:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F86F40268;
	Wed, 17 Jun 2026 23:11:58 +0200 (CEST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id A1F7C4014F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 23:11:56 +0200 (CEST)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7ffbc4d8b8eso3003547b3.2
 for <dev@dpdk.org>; Wed, 17 Jun 2026 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781730716;
 x=1782335516; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZwRUpXY4cb3dfFflhptGsQ9DItvhTcZTxj+QfenbmQ=;
 b=ifR19Ygso75EobdQOLbS4yZ+4Sa9dBU5f9kY9CNtij0pnZLzsisU2GHQEl11JeSPMm
 PkrdffDMeY+JN9eeoSd5bVL+w+Sbl8n/Cu0OnxZKjgm/Qyy5HxlD1TexuFpmLlD0NZzH
 XP3P4sRhMNkbWiDIBIQrzluJAGCSQdjI+6OgVAHLhmgN9qRjAOMflc/YctoUZ/a9SfjW
 kJaZsMdhhlayepwjcRTQM4neMcP6GBHo5SooF47u97kgGz6rN1yvup+M5HQ8/DmH+P6p
 0ISN7D21BZUq/gqDILJJNS3cfJ64TplT3MPbZnwgi4GtL7DuhJforCKMHt2LeRbcEyuG
 8lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781730716; x=1782335516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ZwRUpXY4cb3dfFflhptGsQ9DItvhTcZTxj+QfenbmQ=;
 b=mnUQBrFqKdjoAlOBkKEHxpBg9xe7ggElJFd1GQzyLvW1OLDzUGCSZ9xvnKK5d6t/xX
 CQP4GxvLKEs5NIUWDFfCCZLCD1eY29QLzFoAz/Wpbt4zGgMT5H0vx3J8t7hTAe1yvwdt
 iP+bzM5VyMoDdNoDQrNv9Owf8QSuVD3/O4EKsJ02midKhwKtu6eRMZwThdadHNFYuptZ
 cfR+fJ5SRPeDos4X+d07xf2hD1qcs0n7zgfCL7KECUB1L0k1AgAhN9pOwUc7s12+74kB
 xuKZ/E/A/Y1hNnMd8rEF7H6s9/0I7Bpc6qIrGqmuJymfjkT0/8kIfOoEFh7YpVnBqrrR
 Ky3Q==
X-Gm-Message-State: AOJu0Yx4HI9aE8gYLuHzz5NTgdY1tU8OkV9MeNQm6TPMRFvXQ5OIoDTZ
 FeITwlNnMBZ3FwaQbZ58j+cFzPzBYIs2HQYzzD0qm6M9TZnQ1yP6oDO2qRhL7Iv60mQ=
X-Gm-Gg: AfdE7ckQId5QoFRNZWx52Q6nBqx3D0WsPdMGOZNMr+Grnje96517N8FAM+kG0xTaj3V
 LoYdbR+aAqWYWNoLu4D34TnTw/jrbgGUtVTK1jnhH+TB1wLYZfG/Vl80wxQlz0zmhOfvd2EhLPP
 m+cP1PccHqmWLZ9YHIpO7cByz9sDKI8PTwu7hbluiwzwKQ9IYq1H29Z8qqsO3S97YH/xUxV8atS
 QP+QIePac/ILHLr8Ru/pokxZu3ZL1Z2kwJlySdehXbk9DGMhtfOcjIbyvFG8Y9aYpaTpAVwp2Z9
 Mn9zgcN3zM6plKHruY/+hAJgMClQ52GY7WecqZZ+C3Fkj1R/27cP/uKuo8+UEseNKBhTB62590i
 1OBFA0Ja29OdY8u+zzcL6LHUuaE7cTHJrlqSnmsSfABpAJIMn5n3ymLHEU5pyE2kLHp9fi94IkO
 hF6eEZfeTV5P3ryLf/2swOjahig0G6xYkC8UcTxB4rhN0wZDdjwkc7W6j8VkurgE6A
X-Received: by 2002:a05:690c:6008:b0:7bd:5c9d:dc6f with SMTP id
 00721157ae682-7ffc4f523d5mr7564577b3.1.1781730715961; 
 Wed, 17 Jun 2026 14:11:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ff6a424db9sm13057567b3.22.2026.06.17.14.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 14:11:55 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:11:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v5 0/6] net/gve: add hardware timestamping support
Message-ID: <20260617141152.3cf8b191@phoenix.local>
In-Reply-To: <20260617000712.2195506-1-blasko@google.com>
References: <20260613042300.3760470-1-blasko@google.com>
 <20260617000712.2195506-1-blasko@google.com>
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

On Wed, 17 Jun 2026 00:07:04 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for GVE hardware timestamping
> on DQO queues. To support concurrent access, a mutex lock is introduced
> to protect admin queue operations. A mechanism is then added to
> periodically synchronize the NIC clock via a dedicated control thread,
> and support is introduced for the read_clock ethdev operation.
> Finally, the RX datapath is updated to reconstruct full 64-bit
> timestamps from the 32-bit values in DQO descriptors.

Applied to next-net
