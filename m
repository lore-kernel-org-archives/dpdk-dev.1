Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C816AC9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE1A740E20;
	Sun, 18 Jan 2026 20:13:49 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 16AA340E1B
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:47 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b87693c981fso627321666b.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763627;
 x=1769368427; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oe6m41MQfvhx2I35+hVcB1u03JJo4ZtX3qHibXb4X3U=;
 b=nnjH6PwovTUMmHH1k/XL4kc6wLvuYs5LHeBQlYHX0jjX8ZcQE3rWVkHlWYl/BoQlt4
 bs0DxKCQUmOICnvQGg3T0DGgXmJ3wZ20tGi7vpFm4XCRmwdIBUEJ5SzoYYtQt9p3hcVb
 c23nMEUI/RAarHSB3sqi5B18lo4XtyKu9OPWE339J9kJsYkzT4ARITtEE4LrmeEA4vcn
 ZFvgqzqMjzZSyN34bRj60ZxD2ZWpCqf2U4637Pwu4UyTAnjyXLOdn2g9vPv8GKQDRtMn
 fj1jmuVOl/1yEwnSdJJq+8wT41DrjiClh1+d9gnGI2lAXHRb+z4EMY7dHyBvvbzMWWrU
 xUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763627; x=1769368427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oe6m41MQfvhx2I35+hVcB1u03JJo4ZtX3qHibXb4X3U=;
 b=NTCrPZR3Fz+CNIvceVkQvCzfaODnaGIWSZ+TVn/i0eOcLExWDF+Yga1+3Au211s1hX
 MVVwH2KBawLJ6pCogvgNetKapRVCZcB3f1PG8Vw3Vxdc7kKONXNyqcZ6aGv4IgNUGVRi
 NMoOSJ71qVdYz8ZutuVjqt5p94h7k/DNgCMHwUI5vn25Iz7hwGVm8J5cL50Dcn+mkdz3
 ih3xsCcjk68RY4ee12+1PivtSIcAHlqdid+aLJBnG+cczPZ25UN6OivmfcQzuHubSpUy
 Q+ZxuX6dM+2teCjrQFo3U2YuUyvcc/e/jHniJU/iYK3rpGE22Zsx86j697yEIV+kil8g
 iFWg==
X-Gm-Message-State: AOJu0Yy907NpYDgyjBrTwTniIsGtQfVmrOX6stlIXQzAEWnC90XlGHD+
 t3FYZ0neEOz7hUyfgoYnfNUhZmEmm73XVuSf/fR4aWhqrvO3LAgU2lMzjR6DPvbVH8Yec9sZVXK
 B8JyA
X-Gm-Gg: AY/fxX70Xo1MiXLQ3KTJqpU3qJQ9taBaR0Q5rBTuDbtp07SZqfbKWohqn36HIdI8d9r
 kGlYxxWCBdkZSwboC9be1vKA09DrJxaD07ROgM4+6Nuk+K2Vet5Af7oFQJP5sBwGPKoKeBhmrYJ
 SEbJs6hGHme0F292bzLqmDm7aBbfCR7GWx9gvoOy9PEE8uJi3ZUA8WEwbXL7/6SKfmKGR+fOClm
 ClUI92z5dP6JQMorTHZBlgK0FAS5Wobl8fXb+Qy2d2Gn0TgoXtbPFDEjk9JZPp9zOViCjIArc8e
 +04OWXnVDqq2IbITXVxtecYd2YyVNC23QKL9aGy5kPl2ka+e+0ceOBZc0eoOdB2LWvh6plLbOnu
 6HHFVCEI9tObJcYhIygpWqxsJrzK3B5Hfko1GJpnDgW5xFeB5/erynM6RF3ZEa+23xXTpPMc2aN
 Tsx4CFEBrD0LEmeh7ChUp4/tbddaSuo/1IF1YTFEMbJ3Bhbm9p51dq6PtVAJAG
X-Received: by 2002:a17:906:f5a0:b0:b73:a2ce:540f with SMTP id
 a640c23a62f3a-b8792d5904bmr787403266b.17.1768763626607; 
 Sun, 18 Jan 2026 11:13:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 11/54] doc: correct grammar and formatting in bpf lib guide
Date: Sun, 18 Jan 2026 11:10:14 -0800
Message-ID: <20260118191323.241013-12-stephen@networkplumber.org>
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

Correct several documentation issues:
- Change "an BPF" to "a BPF" (correct article usage)
- Capitalize "dpdk" to "DPDK"
- Change inconsistent bullet point spacing

The BPF library only supports v1 and v2 instructions.
Add a more complete description of that restriction.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/bpf_lib.rst | 46 +++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/doc/guides/prog_guide/bpf_lib.rst b/doc/guides/prog_guide/bpf_lib.rst
index 8c820328b9..b915ed31b8 100644
--- a/doc/guides/prog_guide/bpf_lib.rst
+++ b/doc/guides/prog_guide/bpf_lib.rst
@@ -4,9 +4,9 @@
 Berkeley Packet Filter (BPF) Library
 ====================================
 
-The DPDK provides an BPF library that gives the ability
+The DPDK provides a BPF library that gives the ability
 to load and execute Enhanced Berkeley Packet Filter (eBPF) bytecode within
-user-space dpdk application.
+user-space DPDK application.
 
 It supports basic set of features from eBPF spec.
 Please refer to the
@@ -19,13 +19,13 @@ The library API provides the following basic operations:
 
 *  Create a new BPF execution context and load user provided eBPF code into it.
 
-*   Destroy an BPF execution context and its runtime structures and free the associated memory.
+*  Destroy a BPF execution context and its runtime structures and free the associated memory.
 
-*   Execute eBPF bytecode associated with provided input parameter.
+*  Execute eBPF bytecode associated with provided input parameter.
 
-*   Provide information about natively compiled code for given BPF context.
+*  Provide information about natively compiled code for given BPF context.
 
-*   Load BPF program from the ELF file and install callback to execute it on given ethdev port/queue.
+*  Load BPF program from the ELF file and install callback to execute it on given ethdev port/queue.
 
 Packet data load instructions
 -----------------------------
@@ -64,3 +64,37 @@ Not currently supported eBPF features
  - tail-pointer call
  - eBPF MAP
  - external function calls for 32-bit platforms
+
+Supported BPF instruction set
+-----------------------------
+
+The DPDK BPF library supports eBPF instruction set versions **v1** and **v2**.
+Instructions introduced in v3 and later (such as JMP32, extended atomics,
+signed division, and sign-extending loads) are **not supported**.
+
+When compiling BPF programs with clang, use ``-mcpu=v2`` or earlier to ensure
+compatibility:
+
+.. code-block:: console
+
+   clang -target bpf -mcpu=v2 -O2 -c filter.c -o filter.o
+
+.. warning::
+
+   LLVM 20 and later default to ``-mcpu=v3``, which generates JMP32
+   instructions that DPDK cannot execute. Always specify ``-mcpu=v2``
+   explicitly when compiling BPF programs for use with DPDK.
+
+The following instruction classes are **not supported**:
+
+ - ``BPF_JMP32`` (class 0x06) - 32-bit conditional jumps (v3)
+ - ``BPF_ATOMIC`` with ``BPF_FETCH`` - atomic fetch-and-op, XCHG, CMPXCHG (v3)
+ - ``BPF_SDIV`` / ``BPF_SMOD`` - signed division and modulo (v4)
+ - ``BPF_MOVSX`` - sign-extending register moves (v4)
+ - ``BPF_MEMSX`` - sign-extending memory loads (v4)
+ - ``BPF_JA`` with 32-bit offset (GOTOL) (v4)
+ - ``BPF_BSWAP`` - new byte-swap encoding (v4)
+
+If you encounter validation errors such as ``invalid opcode at pc: N``,
+verify that your BPF program was compiled with a compatible instruction
+set version.
-- 
2.51.0

