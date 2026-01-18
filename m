Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0847C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DFFF42E69;
	Sun, 18 Jan 2026 20:14:43 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 6977442E5A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:41 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b876798b97eso576195866b.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763681;
 x=1769368481; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5j/RJ0xNqSivM6/J4HN++1L8ELtt2ixx2GFxyxvGO4=;
 b=kgzAA5WGDwxp58obX9lUxkvs+adpxEPApqnfHzncUQQUyTIdP8SonuHwsXEwSZOEAJ
 EDgd3U2GGTQD9j62sGUXZoWK9BZKJe80cXY58oVDHU7XCG1ExMRAqoK2RL7rBWoDYM/u
 UV26QxAeR/YOtdU0OiUlDLCX7FUbRSoPN/AH3WspwKbodNLyhyJMBofzEr++Ul2ezVgx
 lvdND8bOigJEejks/DNNoye1kkjxamGQ7MTi3Dcg7FNke+Gim/qiOJoNy48tW0Yiwu+G
 drdbj3NI+1KyNxLPTgBKYg3KFh/EtehtCl3DmWeQBzps6acN4hSZ6fzYqk9WlkDf24vw
 K/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763681; x=1769368481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q5j/RJ0xNqSivM6/J4HN++1L8ELtt2ixx2GFxyxvGO4=;
 b=He3p1PcwMm5ZqWS1Wvgv1p1byK2L6o97fPMkaUpuivHgxkElmKsbmo1H+peCI9szs4
 4gyzuyCaatMNSgftMhsEMq2kyeUNvB1IU+JmRFjVSAVgLp7GO56zkaPlhxf/y6m64OHJ
 I7isrCCabuuIn7ACt5Klz4OwH6Er+M0kdTW1++U680IJKHkBHdiAdkYRrYx5wj8iIXmA
 ovyTaUdXRcTGJYwPehgqBoVM8++iHP72C3oNP2Gu8tbbEofxDo5y0Tot+TL4zooUE2yz
 nXT9rRlX9NwzoZWwxW6DTpv+3C7h6+xGZlgQ1/vWoP49CbGfCm1QHMqBlIJ9ggUs4Z0/
 OiZA==
X-Gm-Message-State: AOJu0YxVUhgga7XP3ybqpsAUtPCFxRwcbQfN/MjAvTIkxfHZXVTBzd6J
 aPtYFAR/r5ApZqH+SNy2AR7TZ6ArTge4indWrrk8bRtaswmIHk6Zedz6+Q225Q/06FtrnCdCOSH
 GIqKi
X-Gm-Gg: AY/fxX5qDXJfMLhTvnl5yUIIA+MvtnvbW3fWKHp3zhWLHLJbTx95T3EP5DGec4PLGgf
 sBJtvXcMJH+VJJjdN9U1dmkfmp6ukmeIj+2gdwhkLX271dwxJv7XRKbQPRN8zZ6zCAaWAt++m3l
 RPgedRITLw78wNHVCI/yuc7WFNYwW/LPtWP/Z4P2UMIp+94FfFfarrCN6wNqfLQe0o2+MFm+X2I
 M/6BoC5SCP9y/mKoS4Xt7a9c4joZD8ng/KrbyXFTuWtZArlAxMbGfab4LtoUota+ALb/61g5vr/
 qER4T1pkyG1iAaxsw7jy1ReLSiKd6FAaLE50rMFnaLSsArmd1Ad/HzhazeKOysNvS6xkm3x4akQ
 0WfeKOCzasngM4zVqRVFaw/vnWtr9DT4hLgy/fCx1jcEQX1ZQVKYxCw1fmftTdUE3sshqBwOseb
 14++xm/ol6qKbCKfU9t5jfo6077KY4b/JEXi9Ay7bC4zMAgFkasEGtCNO++zaK
X-Received: by 2002:a17:907:26c8:b0:b83:6e2b:890d with SMTP id
 a640c23a62f3a-b8792e156bbmr833995666b.25.1768763680883; 
 Sun, 18 Jan 2026 11:14:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 47/54] doc: correct grammar in reorder library guide
Date: Sun, 18 Jan 2026 11:10:50 -0800
Message-ID: <20260118191323.241013-48-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct minor grammar issues in the reorder library documentation:

- add missing "are" in "which are referred to as"
- remove extra space before "mbufs"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/reorder_lib.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/reorder_lib.rst b/doc/guides/prog_guide/reorder_lib.rst
index 3fb5df5570..a5f529145d 100644
--- a/doc/guides/prog_guide/reorder_lib.rst
+++ b/doc/guides/prog_guide/reorder_lib.rst
@@ -36,7 +36,7 @@ mbufs.
 Implementation Details
 -------------------------
 
-The reorder library is implemented as a pair of buffers, which referred to as
+The reorder library is implemented as a pair of buffers, which are referred to as
 the *Order* buffer and the *Ready* buffer.
 
 On an insert call, valid mbufs are inserted directly into the Order buffer and
@@ -62,7 +62,7 @@ be reported as late packets when they arrive. The process of moving packets
 to the Ready buffer continues beyond the minimum required until a gap,
 i.e. missing mbuf, in the Order buffer is encountered.
 
-When draining mbufs, the reorder buffer would return  mbufs in the Ready
+When draining mbufs, the reorder buffer would return mbufs in the Ready
 buffer first and then from the Order buffer until a gap is found (mbufs that
 have not arrived yet).
 
-- 
2.51.0

