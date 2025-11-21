Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E1CFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E4D04026F;
	Fri, 21 Nov 2025 18:09:53 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id D3BD940267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:51 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-bd1ce1b35e7so1406715a12.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744991;
 x=1764349791; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHPWNPKWIEBUZHJ9Vt4v381xsKTw4wqh4xLnAuMivSs=;
 b=zQmhomBu6gqlOrC0644+EetiFuSmTT06f971yFPjLPNBb2srEAO/8wkqiqZaSPNwRd
 5XQ9/ahrTUkEqSqvLxTceKI9lt/ciekuyFQLSfskuAE+NlyJv7y8occpoMP0BEwN4lCU
 iVZEDCGo8yZN+zyo9I+5qAJ6wj+uqDfceZaouBnGyvXuFFXF97WrSsOIsluxmhcKNtg1
 npbEvzkAPjdt9QYt6EXocG46cpwAlE3JQBlCJ50EYO6VGHyIFwFtDW9jc4u97KNCjUvr
 CWck6uO/V4umur9F+erEwhMHJ76CsqFf93LnlBaazY8bfq3iAZzq/FnhdkO73/ENewHA
 RoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744991; x=1764349791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EHPWNPKWIEBUZHJ9Vt4v381xsKTw4wqh4xLnAuMivSs=;
 b=AsEjr5XXxKWL0qAgOf6cG0kkRDMJ2BsMa/442I9xOc5DyuudbpJvIWYBxWbf5f6nVA
 3tck8BC4ynTsIZRj/soAmiBKupKQa9UfDj7hKsLrsFko8cDWlF1Vwk9s9T68cvIJ/dWd
 ihXPvi4W7cQJExOW4A2rpguHJzW5lt5+2Rb86Y9MlAUoW7+tDDsUqxZt/VFjGWWpHuE+
 25nA3n8tVbneqVfBtoCw/2eCRPosCb0RHvTjkJHAgOLHdvx+k9YIdoQ3RjoAoALgwu14
 SXszNvdjQfnI54xRmt1RDKeYKF8FE/sOv23aHOGxxSbtS5u0dAXgSqdPRHoqX+XMG427
 2i3w==
X-Gm-Message-State: AOJu0YwPa+yblQ/cpvbbUg84ThwYCJRqQt/6JjmS6inWhmSJQ0gF3lqO
 7zoCCS87WNmARl56sRdezgUcMIQ53FVkxGdzrB9QwSLOFON+sUAp7mj5q5+dKjAV/5EZn+UDBS+
 FXccM
X-Gm-Gg: ASbGnct6iHnWI+CyKEcIZxy1QwWKwGRbbqk+GkiHo6Y07zjFm/dPsnjbFBhxGC+dqNc
 Ybq+ciKkwt5vZLNFnS8JbcmD2dVQtJ/nNJUw1aqDA8jlYfvuyXyWEPZKKb3Pxk4onNyNXLzLRBJ
 dZCjhev6dGj0RQTKv+pksF8eQZijZ8kpihoAZbwE4luOVXyVPUiMThFDvnU68gjlQkUsahrE/GM
 PPpyUfbv2bzprrjGfcUcjXvS2XI3+KIyNlPCkGavFQKFZOM+4/qh2dCsMPW5PUPIXw+Eyv5ITz0
 HqDJeQSjkBeyJnOy+2lKu650KqHE5DEA+f9iZ8KEOb45svn/JXIv0Ep/BTH/Fii+/BbJw5okp1i
 zIqUf1pa/7fmz0lckDhx1wJ6Q7OR7pmfOOQ+P1hqnC57bi41ycxs6r0HrzmSg0FC8AZtpohz+t/
 vHHIJKQTbI89aabTxpfRvqrjnXf9FXABbIut7w59MlSODfece9YQ==
X-Google-Smtp-Source: AGHT+IEP3NEyEeHk6x5Mf6IEHdCFqkFSSy8AwY1VPWewBTVWRmxrivY4en5feDV8HgUG6DYzEJyxgg==
X-Received: by 2002:a05:693c:8018:b0:2a4:3594:72e7 with SMTP id
 5a478bee46e88-2a71927ab39mr1085236eec.22.1763744990664; 
 Fri, 21 Nov 2025 09:09:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 0/8] tests: fix format truncation warnings
Date: Fri, 21 Nov 2025 09:08:19 -0800
Message-ID: <20251121170947.134502-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

Enable format truncation warnings on the tests and fix where
there was an issue.

v5 - one more case of huge page possible name overflow

Stephen Hemminger (8):
  test: increase size of memzone name
  test: refactor file prefix arg handling
  test: avoid overflowing huge directory path
  test: use unit test runner for eal flags
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: re-enable format-truncation warnings

 app/test/meson.build      |   1 -
 app/test/test_cfgfile.c   |   8 +-
 app/test/test_cryptodev.c |  22 ++++-
 app/test/test_eal_flags.c | 174 ++++++++++++++++----------------------
 app/test/test_memzone.c   |   2 +-
 app/test/test_table_acl.c |   4 +-
 6 files changed, 96 insertions(+), 115 deletions(-)

-- 
2.51.0

