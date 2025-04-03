Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC86C36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 02:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69F734066E;
	Thu,  3 Apr 2025 04:34:57 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 85A074014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 04:34:55 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7c592764e54so48548085a.3
 for <dev@dpdk.org>; Wed, 02 Apr 2025 19:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743647695; x=1744252495; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ReFOJT9rdO/6TpJim2Jv9o/Ci181lFav1AI2bizjaQ=;
 b=VDIQwt3kqMjYzfIQ/SjusBSpRu5DOkpIa0HIC4hqR21xQUF455DZ2CTRmEK2PjZ6d0
 IMtWt0drcm4U070jGoURSZTZ53Wxo1qzngejEY4i1J2JwmD6K5qtXA8fpp5WRp5UcRQQ
 S97fWGIOT9MXQ3+m36S0je0PekCpdj0/sDlro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743647695; x=1744252495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ReFOJT9rdO/6TpJim2Jv9o/Ci181lFav1AI2bizjaQ=;
 b=txhAuu12qpzexrn1W4Pio8rZCevJzzDJpcPwp/w/MpiLZtr34KjST/+TQAeJUhlklV
 40gZca2V7EHKQfJOr8q0UFTRgWvC/duVwgmZo6APOrtcb5ymTNPN1KQKfLaEcyCmgSTk
 dNigO0yKT+Wz9SQ+CJvzE3oDGCzI0f8AkHfubRhkAiUYvGjAetpsbYlVGshKDrHJlLyt
 JciBreeeQEujqcB38AtM8UXIcXdFMTvd76dlLD2XDHBS7jPBeeL3gz+WgeShC5dsGCwd
 PV4eqE6/a6NNyk6KD7ryhtp/qdBXbr+I3RayU+NBOryeBLEWNi7D1ouYvWK5IM+ofwLt
 tjxA==
X-Gm-Message-State: AOJu0YwH2EuQts4K9s/a1XzOEfSR4FytlHZNW9xMdpiVgLCyZOwB3xZ7
 S+Uqf9ZJuFBt882U4p7TwwSypISPiCbqN80wGIkWAfhwiRVilPLdaNJsgsbmSRs=
X-Gm-Gg: ASbGnct+T3zVYouoFB9PihlXXUxX+amw/EOG9T5+o75P5YCajooYxOm9/UONqO+yphL
 r+0OT/8CaqSnqMEagSuWOp6EuykFzkJAHue+PVtgrEBca0lm4INdF7J897QroDiPMooGec3sYlR
 3eKvsZSgA7o7hTAVqfQ0raNAxh8qkMtY6vl7kBx0lCcGFL03ml/GdTNzzFjPXxC97gV6BcQOKnz
 EyhahE3Rckgoy113DkFzSKIc239y/9EdFI0yZ1aFqMa3BLISGViVaHjRkM+jQNacbz/H2RTbE0Z
 LM+gAz7cstBoOh/gqcAowP+bZ25gVBOFzWZxPK4IKasrOot9Ab5+k77DWmQB1swar5RnSBJ/hA8
 =
X-Google-Smtp-Source: AGHT+IGxTdvZHZLDk7XnTf/313DiYFnErQHb5HyRv2n+l7JG68Sb4NqtYZWurjvvjunNt5s3lFFffg==
X-Received: by 2002:a05:620a:24ce:b0:7c5:48bc:8c77 with SMTP id
 af79cd13be357-7c6862e5a34mr2828308185a.12.1743647694869; 
 Wed, 02 Apr 2025 19:34:54 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea7efebsm23764585a.91.2025.04.02.19.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 19:34:54 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, dmarx@iol.unh.edu,
 npratte@iol.unh.edu, thomas.wilks@arm.com, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 0/2] dts: smoke test bugfixes
Date: Wed,  2 Apr 2025 22:30:57 -0400
Message-ID: <20250403023059.1762841-1-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
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

There are two smoke test bugfixes which have come in from our 25.03 DTS
development and which should be resolved with this series.

1. The patchseries which we merged for 25.03 which added the testsuite
specific configs inadvertently broke enabling smoke tests, as we build
the tests config model using the test suite list coming in from the
parsed test_run.yaml, before smoke_tests have been added. Then, later in
the execution this produces a key error. I think that adding a
placeholder smoke tests test suite config is the most reasonable
solution to this. Users are unlikely to specify any test config for
smoke tests as they don't require any, although if they happen to do so,
I understand this change to be non-breaking (and I gave it a test run).

2. I am also seeing the smoke test which relies on regex on
dpdk-devbind.py status output is failing on at least one of our systems
currently. The fact that this broke is rather peculiar since regex
syntax is obviously stable, and my reading of the current regex is that
it "should" work. In any case, I simply changed the regex to a pattern
which is more permissive and still captures the driver in use, which is
what is needed for the testsuite.

Patrick Robb (2):
  dts: include smoke tests in tests config
  dts: update dpdk-devbind script regex

 dts/framework/config/test_run.py   | 3 +++
 dts/tests/TestSuite_smoke_tests.py | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.48.1

