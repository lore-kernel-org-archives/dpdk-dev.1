Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8FDC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 16:38:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E30CD40ECF;
	Thu, 15 May 2025 18:38:13 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id A16BE40E03
 for <dev@dpdk.org>; Thu, 15 May 2025 18:38:12 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7c55500d08cso116843385a.0
 for <dev@dpdk.org>; Thu, 15 May 2025 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747327092; x=1747931892; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nsBaVmHaHFkdN544K0dbo2SPJKu/eiBBksBaX77ROqc=;
 b=hrG2djYNJ4GAn092V9LHejqVMK4CI91BecWNN4FZAwnIuOlmAq+M68yGswn6HTEwUQ
 7Qq69r9wZjaSOMTh2B4r+SOLPQQ7dopo7foMcoDmXKPeyvqoX5grsnEUgUYFlHIIanDK
 vXk1i7ghJxjk/am4oMCntH0xBbCRWds7lqgZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747327092; x=1747931892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nsBaVmHaHFkdN544K0dbo2SPJKu/eiBBksBaX77ROqc=;
 b=ixlDxG6xaZW3X4WzMKhL6b5aEVxAKR6CQwlz5Sbpqvtvk7+28sA+/f89PPnB7NFCcq
 D+INWN0qOSDTJsuQOoFXzNHftln8qy/frl4MaXAF8013x3RaG4s01xTIDRqePhKdOPfE
 UWYSB+0qyaEsxWBalR0nzPXrDyfyHdwpKgUAg1Wgo7cGFq8CxPGas8lSYNwN0uA2mrI2
 ot90IX62PDDNJZHT8rygTPdwAD8ZbiMxyjKGrGvZR3KKxtvWV3imn+XnwslIK9Wvd+zI
 cDVZ2yATh5lZ5VTKBRj0HiqaE1fMweWJ2d4uDhegyRTktWSV7W6cd/0wb4254fimTt1B
 g+9Q==
X-Gm-Message-State: AOJu0YzWltGgcYlGo8dWuKqKRcI21UGln3JP4EApl1BcRtF7FyGvPk9y
 ldDFHa2vrfM9XW0upIjgXmyUHysRRhsgWOo1dowqyTiYkDu3fKMl3hnXxFxzjhLGvdU=
X-Gm-Gg: ASbGncswT+IVpKSBBUqbQwC9ZCJItvTB5HegF5eoLZAI5VRXTEmPSNfWSKrKEb+p7Uf
 QRJj4yJONl1OnkwWkFRAi3EsdXzVthZlEt+HKAmPY+9bzrPPppXLYGIAysWCosSgK9EpK7vQofi
 xj7J5Rkx5uvVAQd9y34vmldxFwiIL/F8NnkZOFKlMKUGRCJ1NGtwGL+/D6tnzljQ9SeVQr0r7D7
 1h1mDLfz8UPYUT9viyv4ACruY7JDIvNFXaS5RkYuR+6Q6kJ7st0BHDmE5yy6gt5U7ZQcbZJsAyH
 wcpKhmaKKRoxVjqa70RaXeh+IpCpeEmtG8jc6TUeuHZ2BR27d5Av0PUMjxKkYw==
X-Google-Smtp-Source: AGHT+IGwRl35/6/T5pSPL608Oho3xDVyPlIfQlE0+nPI/hxvNQfBfEFU8DHijSj3QVC56Q95dk6M6Q==
X-Received: by 2002:a05:620a:24cf:b0:7cd:1efe:ef21 with SMTP id
 af79cd13be357-7cd46779e63mr21662285a.45.1747327091795; 
 Thu, 15 May 2025 09:38:11 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467dd34csm5818685a.47.2025.05.15.09.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 09:38:11 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [RFC PATCH 0/1] rte flow test suite
Date: Thu, 15 May 2025 12:38:08 -0400
Message-ID: <20250515163809.184720-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

This patch adds an initial Flow API test suite, which can
be expanded upon as Flow coverage becomes more widely supported.
Rather than creating one suite to test all possible Flow
rules, which would be statistically impossible due to the number
of possible combinations, this suite creates a framework for easily
implementing test cases in the future.

Dean Marx (1):
  dts: add rte flow test suite

 dts/tests/TestSuite_flow.py | 585 ++++++++++++++++++++++++++++++++++++
 1 file changed, 585 insertions(+)
 create mode 100644 dts/tests/TestSuite_flow.py

-- 
2.49.0

