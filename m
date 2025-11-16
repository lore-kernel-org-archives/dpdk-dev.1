Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB457CCD19A
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 19:00:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74AD7402E3;
	Sun, 16 Nov 2025 20:00:40 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 56F5F402D3
 for <dev@dpdk.org>; Sun, 16 Nov 2025 20:00:39 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo3425975b3a.2
 for <dev@dpdk.org>; Sun, 16 Nov 2025 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763319638;
 x=1763924438; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7gGUqhjLESmf/n3Bio3He61MW+q4nvsJEvpCa42vFI=;
 b=2HqQlzoBPlhomEBvPvmsUbWZ5KKk6D2iq9pV3lDoqAl6GKg+g4vcvpWkufR767p/K5
 0UADtSM/Z1kXaR9zNLxhfN5uPdLcIhMVHJmYFmJbLJINPTswLUXhlD7HghYBYJoUTd2v
 mZCHNa/t07IWRvSeKzDqPxQkh5gP+FFXd0bdgPy4gH8WQefZn/qjrTm5CxqWHMj0Q6mq
 UpGRA2mv2r9GwDV4dzMX1qK6LISDuFH2+j0Nw8Y8STzYlbhTdz3mXbXkzEKU5APpEl6N
 NCSFnPt69C/Fg/xg+D75tDX+MsTkxgcUeD6glrS/WrkFIL6n/fugD/qNxpLnop0RzFP4
 kZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763319638; x=1763924438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C7gGUqhjLESmf/n3Bio3He61MW+q4nvsJEvpCa42vFI=;
 b=kbUApBGXDtWLjj75AIuaqxBKLcIC6wEwOXsINBT99tAMZSjHfIikPGWhq9naRMJjln
 XXkC/GxsSTjSCjJoV4tPqiQWOFab/VDNjr77JeAMHXkzCHGmjAYKeTNbxtWxoq8Ln8pF
 meWH2bZzs+kdYHfq41wFW748YpJ1Pydh1RtE9gOmAUCj1DT9gV8x/4j/arKWBkzOnEA7
 13/9UDXzqmhBgnH1e36ZjFZNx9dgh0Bjs/BL4R5ASN0kYf6KpmCqZ8bA2tS5Oy3oNhaG
 g2r71ADpMWAf0vJu4f7pxmnAypydkiEJ18m8r8xjL/4Q8lePLI+JOiXblrRhPJ4WGBxN
 cx7A==
X-Gm-Message-State: AOJu0Yx8yTMzSQ7uh2I4eemKxD0GkKZD2lupi6x+X1U4fx+OKjFdij4z
 WsBPU422rhMWar9mjaqx4tFNSoQXS/x7uXZBTu9Gm2an1/tzWQ5XwxvbH6GjlTZHZ06/mWtFUVC
 GlFys
X-Gm-Gg: ASbGnctbHctUtFSNu8LP53wIrVzcoT5cQxs2+YaVDAxkZY29G62GJgp+i4Emdl4sh9U
 mlV5xb5IEbHfpHqDz3MN5whHfny+mR876X6jamjIh+sDVs8S8GZuSaMwyOuJjhBXAMLIL547H5F
 7NA1hXt0p/q4n+Oz+/MX01K7gJOyVtT/HVwPrrpD/i4ODsZ/LaQEijHMdMBM88XVJepqxCY8q/n
 7U/Bmm5ra8YjoSQ4eNtu579T4/z6gAciEHQyNMJ4/aInCVC4CHmH7tczeUrOi4h9XublMVKDoYq
 Sw+j2bLP36B0lwwjTz/t9lOCCmEWeRhnFsZJ/PiLvXCtb3ZiKLCqrCQr9r8xb238KELsOmNpSbi
 oXZkWWxObB0tujGzNtVQPxjvi0I91QNhtitmqtEulsVv5Iij+CFYW0xli6ztxfdpvn4KF1UUXwM
 gdmaKiBJuRxhKMPB0qJBt1j2Sax2cTeOyrf5Unt7dUQ9IRbpmAoa06uB8eoXPk
X-Google-Smtp-Source: AGHT+IGKOhe1/wyZVx6Mcyk9G2nu4gBjkcDU37euRlR63Fc6eh7bMz/UqSfoYAZIByjOxpkVUJfjQg==
X-Received: by 2002:a05:7022:6621:b0:119:e569:f27d with SMTP id
 a92af1059eb24-11b8f160a01mr2802154c88.38.1763319637950; 
 Sun, 16 Nov 2025 11:00:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49dad0aefsm28215946eec.3.2025.11.16.11.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 11:00:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/5] enable format-overflow on tests
Date: Sun, 16 Nov 2025 10:59:28 -0800
Message-ID: <20251116190035.76123-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193409.99740-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
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

Changes to allow building all tests with format-overflow
warning enabled.

v2 - fix ACL test

Stephen Hemminger (5):
  test: increase size of memzone name
  test: refactor file prefix arg handling
  test: use unit test runner for eal flags
  test: fix format overflow warning in ACL test
  test: re-enable format-truncation warnings

 app/test/meson.build      |   1 -
 app/test/test_eal_flags.c | 161 ++++++++++++++++----------------------
 app/test/test_memzone.c   |   2 +-
 app/test/test_table_acl.c |   4 +-
 4 files changed, 69 insertions(+), 99 deletions(-)

-- 
2.51.0

