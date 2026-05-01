Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F79FCD3423
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 16:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BB2D40612;
	Fri,  1 May 2026 18:35:39 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 8D7984028C
 for <dev@dpdk.org>; Fri,  1 May 2026 18:35:37 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so5434375eec.0
 for <dev@dpdk.org>; Fri, 01 May 2026 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777653336;
 x=1778258136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdUPYowJGwfJkN4AgobPKuPxCNgTZHH0K3dgXxpQwDA=;
 b=m2IjWU8FMXE/eqhjdLGPLsZJ6+i3Mf0yGKp3LwRjJoD0pgC0SajgXiVX/akWM8rPB0
 fglSTB0127Antm6MVoDt7p3FYIU2U5SLPFFh9bynYYi5BJkK+Yj3eU298lSlGRWRhpoZ
 LC0lSCOSGYnprvloyhiv5UG4/28K/cG2JVlComvT04Mxf2GyvPy3RTiY63o81EKJflV+
 M2kjogBCyj732JKf1w+lGJ53CmKLCUs6xIaJ/gXg77KnA9cbfLRABagNxXihdKXGeLMM
 NHzgNTzew4TBhzK6VwXMJAjEEkIC75XS98fuWnDnyyLAlOG0rTGr+/JXz471xHQBeMK2
 2agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777653336; x=1778258136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tdUPYowJGwfJkN4AgobPKuPxCNgTZHH0K3dgXxpQwDA=;
 b=g0HkZ4oWPukoFjMWt1xXjx/kF6EYBu9Xsu/Uj66KRlbMLrisGVGRInikMdX4ndFneT
 RDcyc8pXK+lYZ15kZTC8sOH7JHr1pB6ZJxSGyC6GuTP7Co9ViuTDz1paF1LLomslOC6z
 fj8nTf2HN3aPNv8WwWzSL/Hj4bdsGNeSxphSsDZrYheYKJoE0/NlaOJShFTObi24/Yo3
 5doH4a8mH0qc/qXcYk77C8cWDTQWq4jyshwigM+bc1/+z0mw1Rgsoh2yWmyIhBUZc5b7
 xX3jexi5dMIpZMGtZylKOD2SvR2/SLYya4kDOqJpM0XTef+yKJLMe0bNL4zqqgTYziFy
 MaWQ==
X-Gm-Message-State: AOJu0Yz+VxAmhS+LsZCaxe6EYbV5UGdxf9smT6iD45dZqFOZi8nQEcKW
 3SscXAufxmMrrHyjWVDl4JR852fZAdbby7QaVgyu7kveVFdCXyGRCDG6b2jVlJzP2gxy/A2ZHtS
 1VUkt
X-Gm-Gg: AeBDieur0yGKHYL/WIVBDQz9LQuVBngz8xqh75BTSdeT+a8WWHoJL0yl6MUtujFH/k6
 nuoQ48RQogVpRln0GG49/LuovgPyGlu86WQ2A1n0ne6Ktj4bWWynWrtS83XjtHVLRg5fNkDrE40
 V+bdk573AhX3/S1NCSExa9tERiS07JczYN4TiFU3nhhl7yxHRqpteW8T+bHvXfO+TA7QnXeut+l
 Smdn6dU086MFmdJORWc/ujTqGfXsCzCGQ+BDwwb2iRjQ5VMNX0yaatyvnpO7ypWATvi71lmDxnH
 cgMQS0jHS1XRJAOViROcX1dmUI5VBlvp5b3UwJIgRYRiPq307p/bt+t1j5egG6n1TDrwjpzjMHa
 QhRW1iHWuSmN+eLy3yQ/GNW+btGLdORn0bQqEaR+omdHKUl/2rdGyH9QNrnu5MMT8ecGtb2CJNR
 9WubIY4Hy/wdk9m0nER0t+WIQUodFK9Mp4IBdMKtKXHBU=
X-Received: by 2002:a05:7301:5f8c:b0:2ea:ed7c:912f with SMTP id
 5a478bee46e88-2efbb28c575mr28045eec.27.1777653336184; 
 Fri, 01 May 2026 09:35:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d5f0sm5196893eec.2.2026.05.01.09.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 09:35:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] test: cleanup assertion macros
Date: Fri,  1 May 2026 09:34:44 -0700
Message-ID: <20260501163533.2689152-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429144632.164970-1-stephen@networkplumber.org>
References: <20260429144632.164970-1-stephen@networkplumber.org>
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

Two patches addressing Bugzilla 1925, which reported missing
parentheses around macro parameters in the DPDK test assertion
macros.

The TEST_ASSERT_BUFFERS_ARE_EQUAL family in app/test/test.h turned
out to have additional issues beyond missing parens -- multiple
evaluation of arguments, no type checking, and a dropped
__VA_ARGS__ in the _OFFSET wrappers -- so patch 1 moves the
comparison logic into static inline helpers.  The macros are now
thin wrappers around the printf / TEST_TRACE_FAILURE / return
TEST_FAILED boilerplate.  Existing call sites need no changes.

Patch 2 is Weijun Pan's original rte_test.h paren fix carried
through unchanged.

v2 - incorporate review feedback

Stephen Hemminger (1):
  test: use inline helpers in buffer comparison macros

Weijun Pan (1):
  test: parenthesize assertion macro parameters

 .mailmap                   |   1 +
 app/test/test.h            | 146 +++++++++++++++++++++++--------------
 lib/eal/include/rte_test.h |  12 +--
 3 files changed, 100 insertions(+), 59 deletions(-)

-- 
2.53.0

