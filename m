Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106060A2610
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=epu+9jqz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EADDC40263;
	Fri, 20 Nov 2026 20:05:12 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 602AA400D7
 for <dev@dpdk.org>; Fri, 20 Nov 2026 20:05:11 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8c70c2ab5a2so613803b3a.3
 for <dev@dpdk.org>; Fri, 20 Nov 2026 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795201509;
 x=1795806309; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1xTKh9QcdDIJkX1WbfF6+UWn2neTZDFJ6McLsnqwW/g=;
 b=epu+9jqzajyQd5kHfdAOCfbsyW73fk40aWe4wKL8AAaL+l9tP1rEE6Tifa0D+rEXdI
 dzMUPRoEy9mDYNnRKMUkWY8MT3gWV3RiLK/fH8x9p6gcv2coDbgbr239PY/v0Yhab4wH
 itI3RvpibjxS3hOpmwzl/DUb1p9H6v7KafVuUajAqXBtRTzoyzu0lJTqkeTl1zXLnZAS
 sU6sl9kuNdLDhNcfRVWzCP4IdLLNV4iHZz4dXJZMCewYJnIlBZryi02DoYc1NcYxN5Mu
 AbVuiQmPxaKgSuNs9goHVj+UxEFaI6KyBWqvgSlCCq1TlaQ5U/Nyu3Jf92QKSLx59L4j
 IBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795201509; x=1795806309;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1xTKh9QcdDIJkX1WbfF6+UWn2neTZDFJ6McLsnqwW/g=;
 b=v6PQcUORuIKW+nr0/goyNWj9e9Pt9Saph0iLuvzeRtyQV5ICHT0yVJOkLQjny4EkgX
 5dLgVLlrZXBQiPqiRn3JDbfHiZ8qh9r0uXi432AdBPxcn9A0NR1M+aJ9FXXCZprf0s5M
 xH65t71e6nyNZcffct334Tj60VY/unne93QJvLw/z9InOxV2cL1Sc/wz9V/YZVAVcbwj
 RUaLykAU/mnCod55Nw14+yjxKTIrGi6V8yHnTONWnCpjNqkHi/MjIU0Om1lWTpgXSdn9
 dt4Zp3SqZEvc2v0tpku03a/NO6zHN8MM2LxSLQNNFNRKLOkZs+wK2ENdwTvON1Mxucv5
 a/rg==
X-Gm-Message-State: APuU4Z8F9h4r56aEt0+8VtR4wSVVaEIHXvfKm7uGO33XO0pszsMA3e1L
 I6I9A6A8HP1WH+/+aNhEyvm+8YCUq9XBDo4He5UXOJ6yFXAisweuqgYAxgRkdM5ETdTiICh5Mh3
 lBWY+NnI=
X-Gm-Gg: AYBFou2ue5/sCViOQEmB3zP3Tr4BYiXCPIouyufHeQpUSp7UvyPqLplRbwnP5IZJpeC
 X8G3qLDjzQaafSSqYpKmp0mIhwV3d0Ia6tz48pWDIHJEVRBKdNKDt7uEstdK91N0toFPhLqH7zf
 G2fr3Yy9k3ylEQjHnXby6Fi5//QkK+0piie4V1VcgkMLk/SXS9mD1+Q1ZePguiWrW+tkLN1IYHG
 KZw864eXwPfYn1qPOr+vRnulpwgZAfsvBxjwGb7vhG0mzJyrWFDI2ycqKi+JpWcft8RM+/ggeyj
 6x5Hs4+3kl85jLhRrP2KfYu20V9g4JJWwBj9KVWLTfL9wPqYlRuFxPF7mCkk8qlldzq/jsPIDj9
 4cz8nzKi27p7QHYLGZzD0lxfObJvjr6odQriGBo8pyenWyFb2wZmYYmmppavblFBU2S3CxYpDKs
 9ekWGmv0DuKw7wV9KR5WuED9kBFhvC2H1IXlMx4LrnoWBzTJ6r79utjpoljdWr0LqP1PSjgQi27
 /388zwDZ3n8KOJCTo+dEit0zMrzpoYkzbQIP8rDmZP0zM90CZZKVcEcqiLPfUfMi7X/l2xh/zFp
 LwPI8N/RQ1GpCAS+krkc3x49P2X1UxsW1fkPuKuzz+ivdzruUcMomOBJAkunVLG52mp2ZMo=
X-Received: by 2002:a05:6a00:a118:b0:8c4:b4ff:45b9 with SMTP id
 d2e1a72fcca58-8c8793b91bbmr3502715b3a.7.1795201509310; 
 Fri, 20 Nov 2026 11:05:09 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873b278f0sm1912747b3a.51.2026.11.20.11.05.08
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:05:08 -0800 (PST)
Date: Fri, 20 Nov 2026 11:05:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: 26.11-rc4 build tests.
Message-ID: <20261120110506.1394765d@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Things that still fallout from my "build with all possibilities" script.
All the compiler versions, documentation and options are fine

ASAN: error in base/ixgbe

In function =E2=80=98ixgbe_aci_debug_array=E2=80=99,
    inlined from =E2=80=98ixgbe_aci_debug=E2=80=99 at ../drivers/net/intel/=
ixgbe/base/ixgbe_e610.c:123:3,
    inlined from =E2=80=98ixgbe_aci_debug=E2=80=99 at ../drivers/net/intel/=
ixgbe/base/ixgbe_e610.c:92:6:
../drivers/net/intel/ixgbe/base/ixgbe_e610.c:59:41: error: =E2=80=98strncat=
=E2=80=99 output may be truncated copying between 43 and 118 bytes from a s=
tring of length 127 [-Werror=3Dstringop-truncation]
   59 |                                         strncat(debug_string, debug=
_portion, remaining_space);
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~

LTO: errors in soring see fix in patchwork

Unreachable code checks still found in lots of places.
