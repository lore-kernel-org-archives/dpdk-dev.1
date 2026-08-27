Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE3C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC3E840150;
	Thu, 27 Aug 2026 23:42:46 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 4E8B64003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:42:45 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso316393a12.0
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866964;
 x=1788471764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1yTwtJWYnAsOI5RSBD4hbT1zzD15Gx/Zr10gQi7dtM=;
 b=m493FJTK5CQMJg9YEAYusDSciJXdXYWorepSnslZ0o5U4hYQ6lzHbjJxlcz+dMgWzT
 hBmi0qD+S9PoXdvekxztg3Aseeefn6InIEpMMYTwq63Z5XKr9jDPVAPrgGibMlRV61Y9
 zSRv+L8cQG5BM2Vge+DcsoJGu+5FzRB75dSNHbLeA7sZMlOUg5dK+Ayy9+aslP9+IinE
 SUFy5encyWiyf1vUFxAV4gSbOYbz5bmmVZ/eXAMgbJcqN7RTNRcz45TIai1VgtS+35Fo
 v0eGeLcfhHPybl3jLBjiqSchm5OCitEwDzsHEfk3VjYga238dkFEClStSkng8zoQGST9
 iI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866964; x=1788471764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1yTwtJWYnAsOI5RSBD4hbT1zzD15Gx/Zr10gQi7dtM=;
 b=JsI4pLs+YH+N2X1Pe978h3oRAd3+9InOpJMFlgz7nJ1/K8qlP1LPlYHWAY6Qe3fPMy
 lqAH1kN+Fr/cII7A4hBBW+0tYjCWqlwk7nD70mCAEC1umPLuGSBhsRMw0635zmN0Dxu/
 zwQnE1gLw6aJH4XOOnEE1pJVpQa/q4mZHf8Mba/ouMjjylfYC5PdZBGByNxZPPxY/odq
 E37e7AyUYFTZM8+1I+rPCYiGXfPO1MT938BVBL6UKy1KyCXevb9zzIjGqADfCOM/Fmtj
 hsl0wFR8QQhKegpzYi44MLjAXVZBqDpBg0erqgOAgk1uwCzEjRON0H/8invdPMdirj5F
 ypdg==
X-Gm-Message-State: AFuF++lvW5x/o7w/nylU14GcFhejHlot5OvIMODLSKdQ1LnRpbB3K6W+
 1v/mArdqLZUlcyRfjKb3yjrPnWz6nwnrUIZ+wfiwLqCG4gft697h3SRJTvOzcCiK+c+w8nZX5Bm
 2Gp6b
X-Gm-Gg: AR+sD127kNyMgzsUvI9Me6xl5CkEDeTbpSrnBzip9ZW+cG9/G/G72QbBdrHJh74tQon
 LfS7P/3KiDJwNhWPRXufqaL8+BX9aAV5aPy3coATvfjZOTM0pu3OsWzApaGDPEWejddJ06w9gEa
 SdnNskSkWPZLqyW22/yarHrfbbZQCuBWvhGFoh463BtmD5P3eRqC/gqQ+PbkfNE8IkZCvNTBYt1
 OJWzEy2znmJnciCH4LxxkJEV4zLtINX5jGJcLfxFXPGNIZLtodYOBUtupj+SHW0t/mPkw0jhVRQ
 aahTD5WfVRkvCEJj1CsoW/RoLyqaULorYRY6mqFqgQmIg5Lvti0VFJ0vNa/z/wNPyqGd8eZUuqS
 jGm9yMCoedl1kOWOYbsbwgJfA3/wdMgB1Xn4z69m/WC21AIwYJDUgOcoAgxoEUzDi5xemgjijwm
 oeSzHIwwHHCX2syEeFC1dvC+HFqrQZXm0pH8ymnTL1xC9dDzG73msia2laS7+ytIsh6oROLevs0
 i/n6Lfit9C9Q+VjK2Ib0I5+klE=
X-Received: by 2002:a05:6a21:e082:b0:3c4:3112:3b with SMTP id
 adf61e73a8af0-3d268bf08eemr3405765637.18.1787866964095; 
 Thu, 27 Aug 2026 14:42:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:42:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 00/10] bpf: JIT and interpreter fixes
Date: Thu, 27 Aug 2026 14:41:39 -0700
Message-ID: <20260827214236.1415047-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <0260608203322.1116296-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
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

BPF fixes, mostly in the JIT backends. Bugzilla 1959 and 1427.

The existing JIT tests were never run on arm64, which is how the gaps
here went unnoticed. The tests now fail rather than skip when a JIT
backend exists but produces nothing.

Tested on x86_64 and arm64.

Christophe Fontaine (1):
  bpf/arm64: fix offset type to allow a negative jump

Stephen Hemminger (9):
  bpf/x86: fix JIT encoding of fixed-width immediates
  test/bpf: add JSET test with small immediate
  bpf: mask shift count in interpreter per RFC 9669
  bpf/arm64: mask shift count per RFC 9669
  test/bpf: add test for large shift
  Subject: [PATCH 07/10] bpf/arm64: add BPF_ABS/BPF_IND packet load
    support
  test/bpf: check that JIT was generated
  test/bpf: check that bpf_convert can be JIT'd
  bpf: fix uninitialized warning

 app/test/test_bpf.c     | 320 +++++++++++++++++++++++++++++++---------
 lib/bpf/bpf_exec.c      |  31 ++--
 lib/bpf/bpf_jit_arm64.c | 204 ++++++++++++++++++++++++-
 lib/bpf/bpf_jit_x86.c   |   6 +-
 lib/bpf/bpf_validate.c  |   2 +-
 lib/bpf/meson.build     |   2 +
 6 files changed, 476 insertions(+), 89 deletions(-)

-- 
2.53.0

