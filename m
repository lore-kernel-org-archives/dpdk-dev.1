Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B61C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1B3242E6E;
	Mon, 14 Sep 2026 07:52:54 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 4AB1942E62
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:53 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-381b831d535so5462365a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365172;
 x=1789969972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZSkJCkZ6ozyNknHlVNgDbbEUGjdlsfURNI/Ea5qgkxA=;
 b=mtcdt3rKy4PJbzjoS1dGjaXOdm1kly2u2VvoPHPXCPxMVK3FlvcVIoGhg+FNKubMs6
 m2xrjDsFg6QJBFDv7ccCnX+WIh6Js4DcbTnudJ7c4qfoN3DHpD7NOQPEAicm/E9/4GfX
 KrJ/7u6V3kT/zc14aqVjR5dy27LEt4mUoLqa0TwsC6cH85hnS0xMzKstv3pmsmeYlW4C
 ib9eavgJD6c2/UU42ZvyLTVkfkIqr03hHnISJvuhNpwFeR1qxyK4NbPbyThXwoNoyLwq
 niNJ7e/jfzHziEgrpW7U4ZVLbM87QYHvUWm0QkpD+qI/hpYdbhqagO9dsPph3g09FzJC
 6YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365172; x=1789969972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZSkJCkZ6ozyNknHlVNgDbbEUGjdlsfURNI/Ea5qgkxA=;
 b=VSv5Fw4GoZkn00p9T4TFHu2wzhU7GcrmMZbjLOvSuebX84UX9/nHzlUobGkMSJJNA2
 56Tu8rn+FCNdIO2XuzeVOnjQ9xZF57bkPCUJNOO9HcHTLIEpDf1WOmUpdLJaG4Gix/Nu
 IvBBYGaDnHlplCkVdkV6t7k2XKqlAWwTDCizGyD2WDE/297zFUnG3WAXEVPCL3uTmsDo
 Yk84CzyXY+625HCOvJEKjIakD5mY5U4IAp+zZmiGHGGJ0pZy+gpzt8eD68Om8YY+Z2yu
 vLDPeNmRyEWKc+/MbAgRcGW3OLK410Qg+AZjgQKCUdDKw/ih/puVILjndHTwa5Sp7byg
 alLQ==
X-Gm-Message-State: AFuF++nq01votTnTZLITmtK8Wl+AYhL9yWSsCO8uRa2rGJa9eFBPEmvR
 wpu2AqTDzwJjWfXWfes34Pn/g7ANOPkJvQjH6ZeEQRPizu4L+cXojhCWs/qPSjrdz4qnKpgWgnZ
 rr7vl150=
X-Gm-Gg: AYBFou1KHkXj1sPkoHWxxbbEbpyJBrL2K6jRkNtyYV/UtlV2etnc1QszYFXR0DcEEyl
 TwHKG6fYmdrRh90fW6kK7uSwHxWLgX4Gv2LakmR0E+8gOkw16ubP+y/nli+9t326eNi0QVXcXp5
 p0jM9QQU+k2zmvc7wBSVsbVdlZNlgJV6MMiP8tXMfKKBTH9wZe8uvQ92BMnvUf2IM8a2rglwlyv
 Mnvw0aRKsnE44nlxJZaZdCMBuiSjtgr+/Xig9Rowcgwy0s1m0yBkAKhwTjJBfZgmft3odCo3/vk
 ZzfzKKpRaEAviF8YAtlA2TDPhTzY8ufP4c94sw91VMhjAaUgipQMc8O1dtj61lfYRqj08MeqkF3
 VcCXa35cGLNU86tR3BqIB2eESWJmqJ4sD1qpZTmBIJfHlVWjMNhRUJzspkUlkRCKUDYr/bJxk45
 KC/DJpwp90p56Xx0tTB2DckOqE4rd6p93eqCsgA3DnRZQ3EQdWcJdiHz4pO4fBcJEC6OBs/Je+z
 vw1UTRpYsJFUPES7IW9QVjvKyZ2EV81yug12w==
X-Received: by 2002:a17:90b:4b05:b0:398:d8eb:cb2a with SMTP id
 98e67ed59e1d1-39dec0f71a0mr2549801a91.23.1789365172358; 
 Sun, 13 Sep 2026 22:52:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 62/62] doc: note kvargs devargs conversion in release notes
Date: Sun, 13 Sep 2026 22:47:33 -0700
Message-ID: <20260914054912.755403-63-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

Record that the drivers were converted to the new kvargs helpers, and
what a user should expect to change: a device argument which is
malformed or out of range is now reported and rejected, where before it
was commonly truncated, wrapped around, or taken as zero.

This is kept as a separate patch at the end of the series rather than
folded into the last driver, so that the note does not depend on any one
driver patch surviving review.

The individual drivers are not listed. At 52 entries the list was too
long to be useful, and it meant a third of the driver patches touched
the release notes only to append a bullet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a663d69655..0399b96dde 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -81,6 +81,24 @@ New Features
   ``rte_kvargs_to_hex`` for the cases where a driver needs a narrower range
   than the target type allows.
 
+  52 drivers were converted to use these helpers. A device argument which
+  is malformed or out of range is now reported and rejected, where before
+  it was commonly truncated, wrapped around, or taken as zero.
+
+  The device arguments which are booleans were converted along with them.
+  Those now take any of the spellings above rather than only ``0`` and
+  ``1``, and ``key`` on its own means true. A value which is not a
+  boolean is rejected, where several drivers previously read it as false.
+  That includes an empty ``key=``, which ``net/pcap`` used to take as
+  true for ``infinite_rx``.
+
+  Two of these change what an existing argument means. ``event/dlb2``
+  only looked for a leading ``y`` in ``vector_opts_enable``,
+  ``default_ldb_port_allocation`` and ``enable_cq_weight``, so ``=1``
+  used to mean false and now means true. ``net/virtio`` compared
+  ``vectorized`` against ``"1"``, so ``vectorized=y`` used to mean false
+  and now means true.
+
 
 Removed Items
 -------------
-- 
2.53.0

