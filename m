Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A37FC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 13:23:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5C56402D2;
	Fri, 18 Apr 2025 15:23:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E42E140263
 for <dev@dpdk.org>; Fri, 18 Apr 2025 15:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744982615; x=1776518615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iDCynj3LQUWCvE7UseZd2YTmyuEG5uT/XtYVP6G5/OM=;
 b=YyNKrRak077tyiD81butSJH5AAwt0ZJlDhdqsxwWJnQp92EdKq49/Rza
 Y8+8UCuOdYEAcUIbPzG5lCCtjPuTL1ZOIcYjlYFt5Sp29JM13giGivG1Z
 7MrtDnPc9IeCieYeLZkpHwLJ5CPD5FW8wV/e0WfhzWkJ2ljGnQJrTccZC
 O3t1XDGP5LQOq9MayMMaXaHwxp+JbX/s/3nw/SyCJK35agPHemP+zWohl
 s4XPlFwzIQ+nbU5VtYZUCDmmPxzjJAC9yAK65EuZYpgp4+gUFoyQTVneU
 CWnFRpcvs1xvRZNBXewe3WhiiM60mCe2N1TgXie3+9aEsdJosiCjFSm1z w==;
X-CSE-ConnectionGUID: 201g+5IeRVeSlEF8wCanPA==
X-CSE-MsgGUID: ONc2V/T7QNeeTlx4HOJbXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46707602"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="46707602"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 06:23:33 -0700
X-CSE-ConnectionGUID: nQF9AuPKTyuhf5J1CStDyg==
X-CSE-MsgGUID: BB7kRHwLQg68UstJSWf5aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="131130683"
Received: from silpixa00401454.ir.intel.com (HELO
 silpixa00401454.ger.corp.intel.com) ([10.237.223.208])
 by fmviesa007.fm.intel.com with ESMTP; 18 Apr 2025 06:23:32 -0700
From: Harry van Haaren <harry.van.haaren@intel.com>
To: dev@dpdk.org
Cc: getelson@nvidia.com, bruce.richardson@intel.com, owen.hilyard@unh.edu,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH 1/3] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Date: Fri, 18 Apr 2025 14:23:22 +0100
Message-Id: <20250418132324.4085336-1-harry.van.haaren@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417151039.186448-1-harry.van.haaren@intel.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
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

This patch is NOT to be considered for merge, it is a demo
of the Rust APIs for Ethdev. There is no actual implementation
of the APIs against the DPDK C functions, this is Rust API only.

To test/run the code (and uncomment things to see errors)
just apply this patch, cd "rust_api_example" and run
$ cargo run

This will compile the API, and spawn 2x threads to poll on
two Rxq instances. The comments in the code explain how the
"Send" and "Sync" attributes are captured per instances of a
struct (e.g. how RxqHandle -> Rxq restricts thread movement).

Signed-off-by: Harry van Haaren <harry.van.haaren@intel.com>
---
 rust_api_example/Cargo.toml  |   6 ++
 rust_api_example/src/main.rs | 189 +++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 rust_api_example/Cargo.toml
 create mode 100644 rust_api_example/src/main.rs

diff --git a/rust_api_example/Cargo.toml b/rust_api_example/Cargo.toml
new file mode 100644
index 0000000000..0137826340
--- /dev/null
+++ b/rust_api_example/Cargo.toml
@@ -0,0 +1,6 @@
+[package]
+name = "rust_api_example"
+version = "0.1.0"
+edition = "2021"
+
+[dependencies]
diff --git a/rust_api_example/src/main.rs b/rust_api_example/src/main.rs
new file mode 100644
index 0000000000..8d0de50c30
--- /dev/null
+++ b/rust_api_example/src/main.rs
@@ -0,0 +1,189 @@
+// Outline for safe DPDK API bindings
+//  - None of the APIs are actually implemented, this is API design only
+//  - This demo runs 2x threads on 2x Rxqs, and cannot accidentally poll incorrectly
+
+pub mod dpdk {
+    pub mod eth {
+        use super::Mempool;
+
+        #[derive(Debug)]
+        pub struct TxqHandle {/* todo: but same as Rxq */}
+
+        // Handle allows moving between threads, its not polling!
+        #[derive(Debug)]
+        pub struct RxqHandle {
+            port: u16,
+            queue: u16,
+        }
+
+        impl RxqHandle {
+            pub(crate) fn new(port: u16, queue: u16) -> Self {
+                RxqHandle { port, queue }
+            }
+
+            // This function is the key to the API design: it ensures the rx_burst()
+            // function is only available via the Rxq struct, after enable_polling() has been called.
+            // It "consumes" (takes "self" as a parameter, not a '&' reference!) which essentially
+            // destroys/invalidates the handle from the Application level code.
+
+            // It returns an Rxq instance, which has the PhantomData to encode the threading requirements,
+            // and the Rxq has the rx_burst() function: this allows the application to recieve packets.
+            pub fn enable_polling(self) -> Rxq {
+                Rxq {
+                    handle: self,
+                    _phantom: std::marker::PhantomData,
+                }
+            }
+        }
+
+        #[derive(Debug)]
+        pub struct Rxq {
+            handle: RxqHandle,
+            // This "PhantomData" tells the rust compiler to Pretend the Rc<()> is in this struct
+            // but in practice it is a Zero-Sized-Type, so takes up no space. It is a compile-time
+            // language technique to ensure the struct is not moved between threads. This encodes
+            // the API requirement "don't poll from multiple threads without synchronisation (e.g. Mutex)"
+            _phantom: std::marker::PhantomData<std::rc::Rc<()>>,
+        }
+
+        impl Rxq {
+            // TODO: datapath Error types should be lightweight, not String. Here we return ().
+            pub fn rx_burst(&mut self, _mbufs: &mut [u8]) -> Result<usize, ()> {
+                // TODO: Design the Mbuf struct wrapper, and how to best return a batch
+                //  e.g.: investigate "ArrayVec" crate for safe & fixed sized, stack allocated arrays
+                //
+                // There is work to do here, but I want to communicate the general DPDK/EAL/Eth/Rxq concepts
+                // now, this part is not done yet: it is likely the hardest/most performance critical.
+                //
+                // call rte_eth_rx_burst() here
+                println!(
+                    "[thread: {:?}] rx_burst: port {} queue {}",
+                    std::thread::current().id(),
+                    self.handle.port,
+                    self.handle.queue
+                );
+                Ok(0)
+            }
+        }
+
+        #[derive(Debug)]
+        pub struct Port {
+            id: u16,
+            rxqs: Vec<RxqHandle>,
+            txqs: Vec<TxqHandle>,
+        }
+
+        impl Port {
+            // pub(crate) here ensures outside this crate users cannot call this function
+            pub(crate) fn from_u16(id: u16) -> Self {
+                Port {
+                    id,
+                    rxqs: Vec::new(),
+                    txqs: Vec::new(),
+                }
+            }
+
+            pub fn rxqs(&mut self, rxq_count: u16, _mempool: Mempool) -> Result<(), String> {
+                for q in 0..rxq_count {
+                    // call rte_eth_rx_queue_setup() here
+                    self.rxqs.push(RxqHandle::new(self.id, q));
+                }
+                Ok(())
+            }
+
+            pub fn start(&mut self) -> (Vec<RxqHandle>, Vec<TxqHandle>) {
+                // call rte_eth_dev_start() here, then give ownership of Rxq/Txq to app
+                (
+                    std::mem::take(&mut self.rxqs),
+                    std::mem::take(&mut self.txqs),
+                )
+            }
+        }
+    }
+
+    #[derive(Debug, Clone)]
+    // Mempool is a long-life object, which many other DPDK things refer to (e.g. rxq config)
+    // Having a Rust lifetime attached to it (while technically correct) would complicate the
+    // code a LOT, and for little value. This is a tradeoff - happy to discuss more if we want.
+    // The choice here is to derive "Clone", allowing handing over multiple instances of the
+    // same Mempool, similar to how Arc<Mempool> would work, but without the reference counting.
+    pub struct Mempool {}
+
+    impl Mempool {
+        pub fn new(_size: usize) -> Self {
+            Self {}
+        }
+    }
+
+    #[derive(Debug)]
+    pub struct Eal {
+        eth_ports: Option<Vec<eth::Port>>,
+    }
+
+    impl Eal {
+        //  allow init once,
+        pub fn init() -> Result<Self, String> {
+            // EAL init() will do PCI probe and VDev enumeration will find/create eth ports.
+            // This code should loop over the ports, and build up Rust structs representing them
+            let eth_port = vec![eth::Port::from_u16(0)];
+            Ok(Eal {
+                eth_ports: Some(eth_port),
+            })
+        }
+
+        // API to get eth ports, taking ownership. It can be called once.
+        // The return will be None for future calls
+        pub fn take_eth_ports(&mut self) -> Option<Vec<eth::Port>> {
+            self.eth_ports.take()
+        }
+    }
+
+    impl Drop for Eal {
+        fn drop(&mut self) {
+            // todo: rte_eal_cleanup()
+        }
+    }
+} // DPDK mod
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
+    // spawn a new thread to use rxq1. This demonstrates that the RxqHandle
+    // type can move between threads - it is not tied to the thread that created it.
+    std::thread::spawn(move || {
+        // Uncomment this: it fails to compile!
+        //   - Rxq2 would be used by this newly-spawned thread
+        //     -- specifically the variable was "moved" into this thread
+        //   - it is also used below (by the main thread)
+        // "value used after move" is the error, on the below code
+        // let mut rxq = rxq2.enable_polling();
+
+        // see docs on enable_polling above to understand how the enable_polling()
+        // function helps to achieve the thread-safety-at-compile-time goal.
+        let mut rxq = rxq1.enable_polling();
+        loop {
+            let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
+            std::thread::sleep(std::time::Duration::from_millis(1000));
+        }
+    });
+
+    // main thread polling rxq2
+    let mut rxq = rxq2.enable_polling();
+    loop {
+        let _nb_mbufs = rxq.rx_burst(&mut [0; 32]);
+        std::thread::sleep(std::time::Duration::from_millis(1000));
+    }
+}
-- 
2.34.1

