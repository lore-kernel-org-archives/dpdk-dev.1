Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B46C369CA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 13:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04DE440430;
	Fri, 18 Apr 2025 15:23:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4484F402E2
 for <dev@dpdk.org>; Fri, 18 Apr 2025 15:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744982617; x=1776518617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VFRdVVWg0NHN42kwlB1f9SfZozTqf5dMfWYAvl+HjPg=;
 b=jpLzojTicqSHvwNRFd6Joy6yCfLS9g3L5o+irp5fSbSK6DNn1+7RQJp9
 dwuS6GyjCOFcxLiCD7N52Jgxf0zDzDLWf2p/+lsgxWQFV5R4V0Rp63KFT
 p6ul3Z5I+4/I9sodaNRSH+XpmcJQgwqz0J3/L8Rf8vUwy9kZibK2bqLWL
 i6pMFg3qIafsM1bgUjpnh/93P7kz5zrD2/1CDxILVUzUmYLCYaNzLTl9w
 3Th+5uGCl+kJkDgbh/DKMrpgjTX18Na2DJ6JKGC9NRKwqhDcY771BL7jt
 jxxhl2+wHneoG3wfZdrsjliHYUpSvmo+KXakOhz09ssa6p35a0Qig0u87 w==;
X-CSE-ConnectionGUID: WjaJfoe0R8qgGI2mo624Ng==
X-CSE-MsgGUID: 43441jUsQWOyYxFJqZMkEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46707609"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="46707609"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 06:23:36 -0700
X-CSE-ConnectionGUID: hkdSTU9zTROE88dc4pjSRA==
X-CSE-MsgGUID: Q8luJn4WQRS+am0jRYpcKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="131130707"
Received: from silpixa00401454.ir.intel.com (HELO
 silpixa00401454.ger.corp.intel.com) ([10.237.223.208])
 by fmviesa007.fm.intel.com with ESMTP; 18 Apr 2025 06:23:35 -0700
From: Harry van Haaren <harry.van.haaren@intel.com>
To: dev@dpdk.org
Cc: getelson@nvidia.com, bruce.richardson@intel.com, owen.hilyard@unh.edu,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH 3/3] rust: showcase port Rxq return for stop() and reconfigure
Date: Fri, 18 Apr 2025 14:23:24 +0100
Message-Id: <20250418132324.4085336-3-harry.van.haaren@intel.com>
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

Since the refactor, use this command to run/test:
  cargo r --example eth_poll

Signed-off-by: Harry van Haaren <harry.van.haaren@intel.com>
---
 rust_api_example/examples/eth_poll.rs | 45 ++++++++++++++++++++---
 rust_api_example/src/lib.rs           | 52 ++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/rust_api_example/examples/eth_poll.rs b/rust_api_example/examples/eth_poll.rs
index cde28df68d..0ef0a28ab9 100644
--- a/rust_api_example/examples/eth_poll.rs
+++ b/rust_api_example/examples/eth_poll.rs
@@ -10,7 +10,7 @@ fn main() {
     let mut ports = dpdk.take_eth_ports().expect("take eth ports ok");
     let mut p = ports.pop().unwrap();
 
-    p.rxqs(2, rx_mempool).expect("rxqs setup ok");
+    p.rxqs(2, rx_mempool.clone()).expect("rxqs setup ok");
     println!("{:?}", p);
 
     let (mut rxqs, _txqs) = p.start();
@@ -21,15 +21,50 @@ fn main() {
 
     std::thread::spawn(move || {
         let mut rxq = rxq1.enable_polling();
-        loop {
+        for _ in 0..3 {
             let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
             std::thread::sleep(std::time::Duration::from_millis(1000));
         }
     });
 
-    let mut rxq = rxq2.enable_polling();
-    loop {
-        let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
+    // "shadowing" variables is a common pattern in Rust, and is used here to
+    // allow us to use the same variable name but for Rxq instead of RxqHandle.
+    let mut rxq2 = rxq2.enable_polling();
+    for _ in 0..2 {
+        let _nb_mbufs = rxq2.rx_burst(&mut [0; 32]);
         std::thread::sleep(std::time::Duration::from_millis(1000));
     }
+
+    // Important! As Port::stop() relies on RxqHandle's being dropped to
+    // reduce the refcount, if the rxq is NOT dropped, it will NOT allow
+    // the port to be stopped. This is actually a win for Safety (no polling stopped NIC ports)
+    // but also a potential bug/hiccup at application code level.
+    // Uncomment this line to see the loop below stall forever (waiting for Arc ref count to drop from 2 to 1)
+    drop(rxq2);
+
+    loop {
+        let r = p.stop();
+        match r {
+            Ok(_v) => {
+                println!("stopping port");
+                break;
+            }
+            Err(e) => {
+                println!("stop() returns error: {}", e);
+            }
+        };
+        std::thread::sleep(std::time::Duration::from_millis(300));
+    }
+
+    // Reconfigure after stop()
+    p.rxqs(4, rx_mempool.clone()).expect("rxqs setup ok");
+    println!("{:?}", p);
+
+    // queues is a tuple of (rxqs, txqs) here
+    let queues = p.start();
+    println!("queues: {:?}", queues);
+    drop(queues);
+
+    p.stop().expect("stop() ok");
+    println!("stopped port");
 }
\ No newline at end of file
diff --git a/rust_api_example/src/lib.rs b/rust_api_example/src/lib.rs
index 0d13b06d85..6b795fc227 100644
--- a/rust_api_example/src/lib.rs
+++ b/rust_api_example/src/lib.rs
@@ -5,20 +5,47 @@
 pub mod dpdk {
     pub mod eth {
         use super::Mempool;
-
+        use std::sync::Arc;
+
+        // PortHandle here is used as a refcount of "Outstanding Rx/Tx queues".
+        // This is useful, but the "runstate" of the port is also useful. They are
+        // similar, but not identical. A more elegant solution is likely possible.
+        #[derive(Debug, Clone)]
+        #[allow(unused)]
+        pub(crate) struct PortHandle(Arc<()>);
+
+        impl PortHandle {
+            fn new() -> Self {
+                PortHandle(Arc::new(()))
+            }
+            fn stop(&mut self) -> Result<(), usize> {
+                // if the count is 1, only the Port itself has a handle left.
+                // In that case, the count cannot go up, so we can stop.
+                // The strange "Arc::<()>::function()" syntax here is "Fully qualified syntax":
+                //  - https://doc.rust-lang.org/std/sync/struct.Arc.html#deref-behavior
+                let sc = Arc::<()>::strong_count(&self.0);
+                if  sc == 1 {
+                    Ok(())
+                } else {
+                    Err(sc)
+                }
+            }
+        }
+        
         #[derive(Debug)]
         pub struct TxqHandle {/* todo: but same as Rxq */}
 
         // Handle allows moving between threads, its not polling!
         #[derive(Debug)]
         pub struct RxqHandle {
+            _handle: PortHandle,
             port: u16,
             queue: u16,
         }
 
         impl RxqHandle {
-            pub(crate) fn new(port: u16, queue: u16) -> Self {
-                RxqHandle { port, queue }
+            pub(crate) fn new(handle: PortHandle, port: u16, queue: u16) -> Self {
+                RxqHandle { _handle: handle, port, queue }
             }
 
             // This function is the key to the API design: it ensures the rx_burst()
@@ -68,6 +95,7 @@ pub mod dpdk {
 
         #[derive(Debug)]
         pub struct Port {
+            handle: PortHandle,
             id: u16,
             rxqs: Vec<RxqHandle>,
             txqs: Vec<TxqHandle>,
@@ -77,6 +105,7 @@ pub mod dpdk {
             // pub(crate) here ensures outside this crate users cannot call this function
             pub(crate) fn from_u16(id: u16) -> Self {
                 Port {
+                    handle: PortHandle::new(),
                     id,
                     rxqs: Vec::new(),
                     txqs: Vec::new(),
@@ -84,10 +113,14 @@ pub mod dpdk {
             }
 
             pub fn rxqs(&mut self, rxq_count: u16, _mempool: Mempool) -> Result<(), String> {
+                // ensure no old ports remain
+                self.rxqs.clear();
+
                 for q in 0..rxq_count {
                     // call rte_eth_rx_queue_setup() here
-                    self.rxqs.push(RxqHandle::new(self.id, q));
+                    self.rxqs.push(RxqHandle::new(self.handle.clone(), self.id, q));
                 }
+                println!("{:?}", self.handle);
                 Ok(())
             }
 
@@ -98,6 +131,17 @@ pub mod dpdk {
                     std::mem::take(&mut self.txqs),
                 )
             }
+
+            pub fn stop(&mut self) -> Result<(), String> {
+                match self.handle.stop() {
+                    Ok(_v) => {
+                        // call rte_eth_dev_stop() here
+                        println!("stopping port {}", self.id);
+                        Ok(())
+                    }
+                    Err(e) => Err(format!("Port has {} Rxq/Txq handles outstanding", e)),
+                }
+            }
         }
     }
 
-- 
2.34.1

