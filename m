Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A4C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 13:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8F40402F0;
	Fri, 18 Apr 2025 15:23:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A394A40263
 for <dev@dpdk.org>; Fri, 18 Apr 2025 15:23:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744982616; x=1776518616;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c8XCdYVjPaydJ8Hh/nwVVVFJ2cKGaroXEGHqb+JovWw=;
 b=mGWet3Sni+QhSfY53SNSu/EF3jFF3q+HnbYfR84CmA9/+uSe9iWINPIq
 suW51bTcSvi52uYSv0CKrimGQDzbFOA6/i/s4CFRRzdtyR6G/iu/CwmhJ
 kjuKQLJSHBu7c5HcVoz0LgDgFjE5/L41BI+9blQ6EPGHwpiRSn7SRWoDi
 hhPfbP99EHsA1ACFS53xwtlFuSjF++oLGOs/ldSiqs0DmB29w927ZJGWs
 GGWDIvVPUWnP1D+7nGw5m1OKdlw14xTHeEvkZS+SFjJRDRfnduQREEBS5
 78K8bx24E/oQiyqHorBPSAmPLY1eI/nTg95gtoM+qlZXy+S06PcNbIJBR A==;
X-CSE-ConnectionGUID: fLHsBne3TnS/Xe2no5UDZA==
X-CSE-MsgGUID: HEvSKbKjRRq3ajqlkSwH8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46707605"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="46707605"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 06:23:35 -0700
X-CSE-ConnectionGUID: NRswnKzRSQ2KPQ9OazmIjQ==
X-CSE-MsgGUID: ydD356D1SP2wpUyKlcKFCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="131130696"
Received: from silpixa00401454.ir.intel.com (HELO
 silpixa00401454.ger.corp.intel.com) ([10.237.223.208])
 by fmviesa007.fm.intel.com with ESMTP; 18 Apr 2025 06:23:33 -0700
From: Harry van Haaren <harry.van.haaren@intel.com>
To: dev@dpdk.org
Cc: getelson@nvidia.com, bruce.richardson@intel.com, owen.hilyard@unh.edu,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH 2/3] rust: split main into example, refactor to lib.rs
Date: Fri, 18 Apr 2025 14:23:23 +0100
Message-Id: <20250418132324.4085336-2-harry.van.haaren@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418132324.4085336-1-harry.van.haaren@intel.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <20250418132324.4085336-1-harry.van.haaren@intel.com>
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

Signed-off-by: Harry van Haaren <harry.van.haaren@intel.com>
---
 rust_api_example/examples/eth_poll.rs    | 35 +++++++++++++++++++
 rust_api_example/src/{main.rs => lib.rs} | 43 ------------------------
 2 files changed, 35 insertions(+), 43 deletions(-)
 create mode 100644 rust_api_example/examples/eth_poll.rs
 rename rust_api_example/src/{main.rs => lib.rs} (77%)

diff --git a/rust_api_example/examples/eth_poll.rs b/rust_api_example/examples/eth_poll.rs
new file mode 100644
index 0000000000..cde28df68d
--- /dev/null
+++ b/rust_api_example/examples/eth_poll.rs
@@ -0,0 +1,35 @@
+// Examples should not require any "unsafe" code.
+#![deny(unsafe_code)]
+
+use rust_api_example::dpdk::{self};
+
+fn main() {
+    let mut dpdk = dpdk::Eal::init().expect("dpdk must init ok");
+    let rx_mempool = dpdk::Mempool::new(4096);
+
+    let mut ports = dpdk.take_eth_ports().expect("take eth ports ok");
+    let mut p = ports.pop().unwrap();
+
+    p.rxqs(2, rx_mempool).expect("rxqs setup ok");
+    println!("{:?}", p);
+
+    let (mut rxqs, _txqs) = p.start();
+    println!("rxqs: {:?}", rxqs);
+
+    let rxq1 = rxqs.pop().unwrap();
+    let rxq2 = rxqs.pop().unwrap();
+
+    std::thread::spawn(move || {
+        let mut rxq = rxq1.enable_polling();
+        loop {
+            let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
+            std::thread::sleep(std::time::Duration::from_millis(1000));
+        }
+    });
+
+    let mut rxq = rxq2.enable_polling();
+    loop {
+        let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
+        std::thread::sleep(std::time::Duration::from_millis(1000));
+    }
+}
\ No newline at end of file
diff --git a/rust_api_example/src/main.rs b/rust_api_example/src/lib.rs
similarity index 77%
rename from rust_api_example/src/main.rs
rename to rust_api_example/src/lib.rs
index 8d0de50c30..0d13b06d85 100644
--- a/rust_api_example/src/main.rs
+++ b/rust_api_example/src/lib.rs
@@ -144,46 +144,3 @@ pub mod dpdk {
         }
     }
 } // DPDK mod
-
-fn main() {
-    let mut dpdk = dpdk::Eal::init().expect("dpdk must init ok");
-    let rx_mempool = dpdk::Mempool::new(4096);
-
-    let mut ports = dpdk.take_eth_ports().expect("take eth ports ok");
-    let mut p = ports.pop().unwrap();
-
-    p.rxqs(2, rx_mempool).expect("rxqs setup ok");
-    println!("{:?}", p);
-
-    let (mut rxqs, _txqs) = p.start();
-    println!("rxqs: {:?}", rxqs);
-
-    let rxq1 = rxqs.pop().unwrap();
-    let rxq2 = rxqs.pop().unwrap();
-
-    // spawn a new thread to use rxq1. This demonstrates that the RxqHandle
-    // type can move between threads - it is not tied to the thread that created it.
-    std::thread::spawn(move || {
-        // Uncomment this: it fails to compile!
-        //   - Rxq2 would be used by this newly-spawned thread
-        //     -- specifically the variable was "moved" into this thread
-        //   - it is also used below (by the main thread)
-        // "value used after move" is the error, on the below code
-        // let mut rxq = rxq2.enable_polling();
-
-        // see docs on enable_polling above to understand how the enable_polling()
-        // function helps to achieve the thread-safety-at-compile-time goal.
-        let mut rxq = rxq1.enable_polling();
-        loop {
-            let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
-            std::thread::sleep(std::time::Duration::from_millis(1000));
-        }
-    });
-
-    // main thread polling rxq2
-    let mut rxq = rxq2.enable_polling();
-    loop {
-        let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
-        std::thread::sleep(std::time::Duration::from_millis(1000));
-    }
-}
-- 
2.34.1

